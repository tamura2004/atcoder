require "pathname"
require "listen"
require_relative "log"
require_relative "runner"

# フォルダを監視し変更のあったファイルを実行
#
# src/配下：ソルバーまたは入力ファイルとしてソルバーを実行
# lib/配下：ライブラリまたはテストプログラムとしてテストプログラムを実行
class Watcher
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
    Listen.to("src", "lib") do |changed_full_paths|
      # type, path = file_type(full_path&.first)
      @runner.run(changed_full_paths)
    end
  end
end
