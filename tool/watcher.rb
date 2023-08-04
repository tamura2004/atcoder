# 現状の問題
# ライブラリのユニットテストが抽象化されておらず、コード埋め込みで汚い、拡張性皆無
# テンプレートへのファイル名埋め込みに制限ありすぎ。ソース名のみ一箇所。"%s" % filenameだから
#
# 解決
# コマンドラインはERBインスタンスで持つ。実行時のコンテキスト（binding）で埋め込む
# 各種ファイル名の規則は必要（src, target, executable, builder, clipboard, executer)
#
# コマンド列のプログラムからの分離は良い
# yamlで外出し、
# 埋め込み変数は、src、test
# srcは元ソース位置か、ビルドで生成されたソース位置、引数を受け取る側が意識する必要はないので
# どちらもsrcで受け取り、出し分けはRunnerクラスの責務とする。
# testはsrcとは別にする。そもそも受け取れるファイルが違うので。

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
    @listener = Listen.to("src", "lib") do |changed_full_paths|
      changed_full_paths.each do |changed_full_path|
        path = Pathname(changed_full_path).relative_path_from(root)
        Log.info "#{path} has just been changed."
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
