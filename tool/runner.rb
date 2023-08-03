require "pathname"
require_relative "log"
require_relative "code_runner"
require_relative "lib_runner"

# 変更されたソースのパスに応じて実行処理
class Runner
  # ファイルタイプから変更ファイルのフルパスが満たす正規表現を得る
  TYPES = {
    input: /input\.txt$/,
    src: /^src/,
    test: /test|spec/,
  }

  # 初期化
  def initialize
    @code_runner = CodeRunner.new
    @test_runner = TestRunner.new
  end

  # 実行
  def run(full_paths)
    full_paths.each do |full_path|
      type, path = file_type(full_path)
      case type
      when :src
        Log.info("#{path} has just been chaned.\n")
        @code_runner.run(:src, path)
      when :input
        Log.info("input).txt has just been chaned. Use last run src: #{code_runner.last_run}\n")
        @code_runner.run(:input, path)
      when :lib
        @test_runner.run(:lib, path)
      when :test
        @test_runner.run(:test, path)
      end
    end
  end

  private

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
