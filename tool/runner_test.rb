require "minitest/autorun"
require_relative "runner"

class RunnerTest < Minitest::Test
  def test_case
    Dir.chdir("..")
    @runner = Runner.new
    assert_equal @runner.send(:home), Pathname("/home/tamura/project/ruby/atcoder")
    type, path = @runner.send(:file_type, "/home/tamura/project/ruby/atcoder/src/input.txt")
    assert_equal type, :input
    assert_equal path, Pathname("src/input.txt")
  end
end
