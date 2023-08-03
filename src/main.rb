class Watcher
  def initialize
    @src = "one"
  end

  def run(src = @src)
    @src = src
    pp @src
  end
end

w = Watcher.new

w.run("hoge")
w.run
w.run("fuga")
w.run
