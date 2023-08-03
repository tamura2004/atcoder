require_relative "log"

# ライブラリテストの実行
class TestRunner
  # 初期化
  def initialize
  end

  def run(type, path)
    Log.info "TestRunner#run is called with type = #{type}, path = #{path}"
  end
end
