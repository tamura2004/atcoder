require "yaml"
require "erb"
require_relative "log"

# ライブラリテストの実行
class TestRunner
  attr_reader :src, :test

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
    update_lang(path)
  end

  def src=(path)
    @src = path
    update_lang(path)

    @test = ERB.new(@config["src_to_test"][@lang]).result(binding)
  end

  def run
    tester = @config["tester"][@lang]
    if tester.nil?
      pp @lang
      pp @config["tester"]
      exit
    end
    tester_commandline = ERB.new(tester).result(binding)
    Log.info tester_commandline

    system tester_commandline
  end

  private

  def update_lang(path)
    raise "bad path: #{pash}" unless path.respond_to?(:extname)
    @extname = path.extname
    @lang = @config["ext_to_lang"][@extname]
  end
end
