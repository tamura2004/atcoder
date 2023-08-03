require "open3"
require_relative "log"

# コマンド実行
class Cmd
  attr_accessor :stdin
  attr_reader :stdout, :stderr

  def initialize(cmd)
    @cmd = cmd
    @stdin = nil
    @stdout = nil
    @stderr = nil
  end

  def run
    return nil if @cmd.nil?

    if stdin.nil?
      @stdout, @stderr, _ = Open3.capture3(@cmd)
    else
      @stdout, @stderr, _ = Open3.capture3(@cmd, stdin_data: @stdin)
    end
    Log.error @stderr

    return @stdout
  end
end
