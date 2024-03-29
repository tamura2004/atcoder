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
    root = Pathname.pwd
    @timestamp = Time.now - 3

    @listener = Listen.to("src", "lib") do |changed_full_paths|
      next if (Time.now - @timestamp) < 3.0
      @timestamp = Time.now

      changed_full_paths.each do |changed_full_path|
        path = Pathname(changed_full_path).relative_path_from(root)
        Log.info "#{path} has been changed."
        @runner.run(path)
      end
    end
  end

  # 監視開始
  def start
    @listener.start
    Log.info("=" * 50)
    Log.info("Watching. Ready for change.")
    sleep
  end
end
