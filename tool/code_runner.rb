require "pathname"
require "open3"
require "erb"
require "yaml"
require_relative "log"

# ソルバーの実行
class CodeRunner
  attr_reader :src

  # 初期化
  def initialize
    @config = YAML.load_file("tool/config.yaml")
    @input = Pathname("src/input.txt")
    @src = nil
    @extname = nil
    @lang = nil
  end

  # ソースコード更新
  def src=(path)
    raise "bad path: #{path}" unless path.respond_to?(:extname)

    @src = path
    @extname = path.extname
    @lang = @config["ext_to_lang"][@extname]

    if @lang.nil?
      Log.warn "Unable to decide lang type of #{path} #{@extname}"
      return
    end

    start_time = Time.now
    build
    copy_to_clipboard
  end

  # プログラムを実行、引数省略時は前回処理ソースを実行
  def run
    if @src.nil?
      Log.warn "No src: #{@src}"
      return
    end

    start_time = Time.now
    copy_to_clipboard
    compile
    execute
  end

  # ビルダーがあれば適用してtarget/target.#{extname}に保存
  # ビルダーには標準入力から渡す（あとで変えるかも）
  # @srcを更新
  def build
    builder = @config["builder"][@lang]
    return if builder.nil?

    builder_commandline = ERB.new(builder).result(binding)
    Log.info builder_commandline

    Open3.popen3(builder_commandline) do |stdin, stdout, stderr, wait_thread|
      stdin.puts @src.read
      stdin.close
      target = Pathname("target/target").sub_ext(@extname)
      Log.error stderr.read
      target.open("w") do |writer|
        writer.puts stdout.read
      end
      @src = target
    end
  end

  # @srcをクリップボードにコピー
  def copy_to_clipboard
    clipboard = @config["clipboard"][os]
    clipboard_commandline = ERB.new(clipboard).result(binding)
    Open3.popen3(clipboard_commandline) do |stdin, stdout, stderr, wait_thread|
      stdin.puts @src.read
      stdin.close
      Log.error stderr.read
    end
  end

  # srcをコンパイルしてexecutableを作成
  # executableは言語により指定方法が異なるので、直接埋め込み
  def compile
    compiler = @config["compiler"][@lang]
    return if compiler.nil?

    compiler_commandline = ERB.new(compiler).result(binding)
    Log.info compiler_commandline
    Open3.popen3(compiler_commandline) do |stdin, stdout, stderr, wait_thread|
      stdin.close
      Log.error stderr.read
    end
  end

  # executableを実行
  def execute
    executer = @config["executer"][@lang]
    if executer.nil?
      Log.warn "No executer for lang: #{@lang}. Check tool/config.yaml"
      return
    end

    executer_commandline = ERB.new(executer).result(binding)
    Log.info executer_commandline
    start_time = Time.now
    Open3.popen3(executer_commandline) do |stdin, stdout, stderr, wait_thread|
      stdin.puts @input.read
      stdin.close
      puts <<~"MSG"
             #{"=" * 48}
             === stdout ===
             #{stdout.read}
             === stderr ===
             #{stderr.readlines.first(10)}
             === time ===
             #{sprintf('%.2fms\n', (Time.now - start_time) * 1000)}



           MSG
    end
  end

  def os
    return "wsl" if `which clip.exe` != ""
    return "mac" if `which pbcopy` != ""
    "linux"
  end
end
