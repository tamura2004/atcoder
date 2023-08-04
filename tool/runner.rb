require "pathname"
require_relative "log"
require_relative "code_runner"
require_relative "test_runner"

# 変更されたソースのパスに応じて実行処理
class Runner
  # 初期化
  def initialize
    @code_runner = CodeRunner.new
    @test_runner = TestRunner.new
  end

  # 実行
  def run(path)
    raise "bad path: #{path}" unless path.respond_to?(:to_s)
    case path.to_s
    when /input\.txt$/
      @code_runner.run
    when /^src/
      @code_runner.src = path
      @code_runner.run
    when /test|spec/
      @test_runner.test = path
      @test_runner.run
    else
      @test_runner.src = path
      @test_runner.run
    end
  end
end
