require "yaml"
require "erb"
require_relative "log"

# ライブラリテストの実行
class TestRunner
  # 初期化
  def initialize
    @config = YAML.load_file("tool/config.yaml")
    @test = nil
    @lang = nil
    @extname = nil
    @src = nil
  end

  def test=(path)
    @test = path
  end

  def src=(path)
    @target = path
    raise "bad path: #{pash}" unless path.respond_to?(:extname)

    @extname = path.extname
    @lang = @config["ext_to_lang"][@extname]

    dirname = path.dirname
    basename = path.basename
    extname = path.extname
    @test = ERB.new(@config["src_to_test"][@lang]).result(binding)
  end

  def run
    tester = @config["tester"][@lang]

    test = @test
    tester_commandline = ERB.new(tester).result(binding)

    Open3.popen3(tester_commandline) do |stdin, stdout, stderr, wait_thread|
      stdin.close
      puts <<~"MSG"
             #{"=" * 48}
             === stdout ===
             #{stdout.read}

             === stderr ===
             #{stderr.read}
           MSG
    end
  end
end
