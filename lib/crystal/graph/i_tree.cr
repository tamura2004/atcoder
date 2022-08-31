module ITree
  abstract def n : Int32
  abstract def m : Int32

  def tree!
    raise "木ではありません: 頂点数 #{n} - 1 != 辺数 #{m}" if n - 1 != m
  end

  def tree?
    n - 1 == m
  end
end
