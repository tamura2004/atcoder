# 重みなし木
class Tree
  getter n : Int32
  getter g : Array(Array(Int32))
  delegate "[]", to: g

  def initialize(n)
    @n = n.to_i
    @g = Array.new(n) { [] of Int32 }
  end

  def initialize(n)
    initialize(n)
    (n-1).times do
      yield self
    end
  end

  # 辺の追加
  def add(v, nv, origin = 1, both = true)
    v = v.to_i - origin
    nv = nv.to_i - origin
    g[v] << nv
    g[nv] << v if both
  end

  # テスト用グラフ
  def self.make(n, type = :random)
    Tree.new(n) do |g|
      (1...n).each do |nv|
        v = case type
            when :bus then nv - 1
            when :uni then 0
            else           rand(0...nv)
            end
        g.add v, nv, origin: 0
      end
    end
  end

  # デバッグ用：アスキーアートで可視化
  def debug(origin = 1)
    case n
    when 0
      puts "++"
      puts "++"
      return
    when 1
      puts "+---+"
      puts "| #{origin} |"
      puts "+---+"
      return
    end

    File.open("debug.dot", "w") do |fh|
      fh.puts "digraph tree {"
      n.times do |v|
        g[v].each do |nv|
          next if v >= nv
          fh.puts "  #{v + origin} -- #{nv + origin};"
        end
      end
      fh.puts "}"
    end
    puts `cat debug.dot | graph-easy --from=dot --as_ascii`
  end
end
