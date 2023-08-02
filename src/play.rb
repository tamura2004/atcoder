require "pathname"
require "listen"
require "open3"
require "colorize"

# フォルダを監視し変更のあったソルバーかライブラリのテストを実行
class Watcher
  attr_reader :home, :listener, :runner, :logger

  # ファイルタイプから変更ファイルのフルパスが満たす正規表現を得る
  TYPES = {
    input: /input\.txt$/,
    src: /^src/,
    test: /test|spec/,
  }

  # 初期化、およびファイル変更時の呼び出し処理を定義
  def initialize
    @logger = Logger.new
    @home = Pathname.pwd
    @runner = Runner.new
    @listener = Listen.to("src", "lib") do |full_path|
      type, path = file_type(full_path)
      runner.run(type, path)
    end
  end

  # 監視開始
  def start
    @listener.start
    logger.info("=" * 50)
    logger.info("Watching. Ready for change.")
    sleep
  end

  private

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
    path = Pathname(full_path&.first).relative_path_from(home)
    TYPES.each do |type, regexp|
      return [type, path] if path.to_s =~ regexp
    end
    [:lib, path]
  end
end

# 変更されたソースのパスに応じて実行処理
class Runner
  attr_reader :code_runner, :test_runner, :logger

  # 初期化
  def initialize
    @code_runner = CodeRunner.new
    @test_runner = TestRunner.new
    @logger = Logger.new
  end

  # 実行
  def run(type, path)
    case type
    when :src
      logger.info("#{path} has chaned.\n")
      code_runner.run(path)
    when :input
      logger.info("input.txt has chaned. Use last run src: #{code_runner.last_run}\n")
      code_runner.run
    when :lib
      test_runner.run(:lib, path)
    when :test
      test_runner.run(:test, path)
    end
  end
end

# プログラムの実行
class CodeRunner
  attr_reader :sec, :input, :logger

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
    @logger = Logger.new
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
    if bunler.nil?
      stdout = src.readlines
    else
      stdout, stderr, _ = Open3.capture3(cmd: bundler, stdin_data: src.to_s)
      logger.warn stderr
    end
    target.open("w") do |writer|
      writer.puts stdout
    end
  end

  # targetをクリップボードにコピー
  def copy_to_clipboard(bundled_src)
  end

  # targetをコンパイルしてexecutableを作成
  def compile(src)
  end

  # executableを実行
  def exec(src)
    start_time = Time.now
    stdout, stderr, _ = Open3.capture3(src.to_s, stdin_data: input.to_s)
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
  attr_reader :logger

  # 初期化
  def initialize
    @logger = Logger.new
  end
end

# ロガー。色付き出力。
class Logger
  def initialize
  end

  # エラー出力（赤）
  def error(msg)
    STDERR.puts msg.colorize(:red)
  end

  # 成功出力（緑）
  def success(msg)
    STDERR.puts msg.colorize(:green)
  end

  # 情報出力（青）
  def info(msg)
    STDERR.puts msg.colorize(:blue)
  end

  # 警告出力（黃）
  def warn(msg)
    STDERR.puts msg.colorize(:yellow)
  end
end

Watcher.new.start
