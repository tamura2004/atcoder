require_relative "cmd"

# ソルバー
# 競技プログラミングの個別問題への回答のソースコードをソルバーと呼ぶ
class Solver
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

  # path: PathnameObjectでatcoderプロジェクト直下からの相対参照
  def initialize(path)
    @path = path
  end

  def run
    @executer.stdin = File.open("src/inpute.txt").read
    @executer.run
  end

  private

  def extname
    @path.extname
  end

  def lang
    EXT_TO_LANG[extname]
  end

  def bundle
    cmd = Cmd.new BUNDLER[lang]
    cmd.stdin = @path.read
    stdout = cmd.run
    return if stdout.nil?
    pp cmd
    pp stdout
    File.open("target/target#{extname}", "w") do |writer|
      writer.puts stdout
    end
  end

  def compile
    compiler_format_string = COMPILER[lang]
    return if compiler_format_string.nil?
    cmd = Cmd.new(compiler_format_string % path)
    cmd.run
  end

  def execute
    executer_format_string = EXECUTER[lang]
    return if executer_format_string.nil?
    cmd = Cmd.new(executer_format_string % path)
    cmd.stdin = File.open("src/input.txt").read
    cmd.run
  end
end
