require "pathname"
require "listen"
require "open3"
require "colorize"

# ロガー。色付き出力。
class Log
  # エラー出力（赤）
  def self.error(msg)
    STDERR.puts msg.colorize(:red)
  end

  # 成功出力（緑）
  def self.success(msg)
    STDERR.puts msg.colorize(:green)
  end

  # 情報出力（青）
  def self.info(msg)
    STDERR.puts msg.colorize(:blue)
  end

  # 警告出力（黃）
  def self.warn(msg)
    STDERR.puts msg.colorize(:yellow)
  end
end

# フォルダを監視し変更のあったソルバーかライブラリのテストを実行
class Watcher
  # ファイルタイプから変更ファイルのフルパスが満たす正規表現を得る
  TYPES = {
    input: /input\.txt$/,
    src: /^src/,
    test: /test|spec/,
  }

  # 初期化、およびファイル変更時の呼び出し処理を定義
  def initialize
    @runner = Runner.new
  end

  # 監視開始
  def start
    listener.start
    Log.info("=" * 50)
    Log.info("Watching. Ready for change.")
    sleep
  end

  def listener
    Listen.to("src", "lib") do |full_path, _, _|
      type, path = file_type(full_path&.first)
      @runner.run(type, path)
    end
  end

  def home
    Pathname.pwd
  end

  # ファイルのフルパスを元に、[タイプ、パスオブジェクト]を返す
  #
  # タイプ
  # :src   => ソルバのソースファイル
  # :input => 入力情報ファイル
  # :lib   => ライブラリのソースファイル
  # :test  => ライブラリのテストファイル
  #
  # パスオブジェクト 実行フォルダから相対参照のPathnameオブジェクト
  def file_type(full_path)
    path = Pathname(full_path).relative_path_from(home)
    TYPES.each do |type, regexp|
      return [type, path] if path.to_s =~ regexp
    end
    [:lib, path]
  end
end

# 変更されたソースのパスに応じて実行処理
class Runner
  # 初期化
  def initialize
    @code_runner = CodeRunner.new
    @test_runner = TestRunner.new
  end

  # 実行
  def run(type, path)
    case type
    when :src
      Log.info("#{path} has chaned.\n")
      @code_runner.run(path)
    when :input
      Log.info("input).txt has chaned. Use last run src: #{code_runner.last_run}\n")
      @code_runner.run
    when :lib
      @test_runner.run(:lib, path)
    when :test
      @test_runner.run(:test, path)
    end
  end
end

# プログラムの実行
class CodeRunner
  attr_reader :src, :input

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
    @src = Pathname("src/main.cr")
    @input = Pathname("src/input.txt")
  end

  # プログラムを実行、引数省略時は前回処理ソースを実行
  def run(src = @src)
    @src = src
    bundle            # src -> target
    copy_to_clipboard # target -> clipboard
    compile           # target -> executable
    exec              # excecute executable
  end

  private

  # モジュールバンドル処理を行いtargetを出力
  def bundle
    bundler = BUNDLER[extname]
    if bundler.nil?
      stdout = @src.readlines
    else
      stdout, stderr, _ = Open3.capture3(cmd: bundler, stdin_data: @src.to_s)
      Log.info(stderr)
    end
    target.open("w") do |writer|
      writer.puts stdout
    end
  end

  # targetをクリップボードにコピー
  def copy_to_clipboard
    `cat #{target} | pbcopy`
    # Open3.capture3(cmd: "pbcopy", stdin_data: target.to_s)
    # Open3.capture3(cmd: "pbcopy", stdin_data: target.to_s)
  end

  # targetをコンパイルしてexecutableを作成
  def compile
  end

  # executableを実行
  def exec
    return
    start_time = Time.now
    stdout, stderr, _ = Open3.capture3(@src.to_s, stdin_data: @input.to_s)
    puts "=" * 50
    puts "=== stdout ==="
    puts stdout
    puts
    puts "=== stderr ==="
    puts stderr
    puts
    puts "=== time ==="
    printf("%.2fms\n", (Time.now - start_time) * 1000)
  end

  # 拡張子名
  def extname
    @src.extname
  end

  # バンドル処理後のソース
  #
  # target/target[拡張子は同じ]で固定
  def target
    Pathname("target/target").sub_ext(extname)
  end

  # 言語名
  def lang
    EXT_TO_LANG[extname]
  end
end

# ライブラリテストの実行
class TestRunner
  # 初期化
  def initialize
  end
end

w = Watcher.new
w.listener.start
sleep
