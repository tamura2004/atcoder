require "colorize"

# ロガー。色付き出力。
class Log
  # エラー出力（赤）
  def self.error(msg)
    return if msg == ""
    STDERR.puts msg.colorize(:red)
  end
  
  # 成功出力（緑）
  def self.success(msg)
    return if msg == ""
    STDERR.puts msg.colorize(:green)
  end
  
  # 情報出力（青）
  def self.info(msg)
    return if msg == ""
    STDERR.puts msg.colorize(:blue)
  end
  
  # 警告出力（黃）
  def self.warn(msg)
    return if msg == ""
    STDERR.puts msg.colorize(:yellow)
  end
end
