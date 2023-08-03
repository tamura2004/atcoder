require "pathname"
require "open3"
require_relative "log"

# ソルバーの実行
class CodeRunner
  attr_accessor :solver, :lang, :extname, :input

  # 拡張子から言語名
  EXT_TO_LANG = {
    ".cr" => "crystal",
    ".scala" => "scala",
  }

  # 言語名からバンドラ
  BUNDLER = {
    "crystal" => "ruby build_crystal.rb",
    "scala" => "ruby build_scala.rb",
  }

  # 言語名からコンパイラ
  COMPILER = {}

  # 言語名から実行コマンド
  EXECUTER = {
    "crystal" => "crystal run %s",
  }

  # 初期化
  def initialize
    @solver = Pathname("src/main.cr")
    @lang = "crystal"
    @extname = ".cr"
    @input = Pathname("src/input.txt")
  end

  # プログラムを実行、引数省略時は前回処理ソースを実行
  def run(type, solver = nil, lang = nil, extname = nil)
    case type
    when :input
      copy_to_clipboard
      execute
    when :src
      @solver = solver
      @lang = lang
      @extname = extname

      bundle            # src -> target
      copy_to_clipboard # target -> clipboard
      compile           # target -> executable
      execute           # excecute executable
    end
  end

  # モジュールバンドル処理を行いtargetを出力
  def bundle(input_io = @solver, output_io = nil)
    output_io ||= Pathname("target/target").sub_ext(extname).open("w")
    if bundler.nil?
      # バンドラーがないならソースをそのまま出力
      stdout = input_io.read
    else
      stdout, stderr, _ = Open3.capture3(bundler, stdin_data: input_io)
      Log.error(stderr)
    end

    output_io.puts stdout
  end

  def bundler
    BUNDLER[lang]
  end

  # targetをクリップボードにコピー
  def copy_to_clipboard
    # `cat #{target} | pbcopy`
    # Open3.capture3(cmd: "pbcopy", stdin_data: target.to_s)
    # Open3.capture3(cmd: "pbcopy", stdin_data: target.to_s)
  end

  # targetをコンパイルしてexecutableを作成
  def compile
  end

  # executableを実行
  def execute
    # return
    start_time = Time.now
    # stdout, stderr, _ = Open3.capture3(@solversrc.to_s, stdin_data: @input.to_s)
    # puts "=" * 50
    # puts "=== stdout ==="
    # puts stdout
    # puts
    # puts "=== stderr ==="
    # puts stderr
    # puts
    # puts "=== time ==="
    printf("%.2fms\n", (Time.now - start_time) * 1000)
  end
end
