module Connectable(E)
  # 双方向に辺を追加する
  #
  # 頂点の番号は`0-indexed`
  def add_both_edge(a : Int, b : Int, c : Int) : Nil
    add_edge(a, b, c)
    add_edge(b, a, c)
  end

  # 辺を追加する
  #
  # 頂点の番号は`1-indexed`
  def add_edge_1_indexed(a : Int, b : Int, c : Int) : Nil
    add_edge(a - 1, b - 1, c)
  end

  # 双方向に辺を追加する
  #
  # 頂点の番号は`1-indexed`
  def add_both_edge_1_indexed(a : Int, b : Int, c : Int) : Nil
    add_edge_1_indexed(a - 1, b - 1, c)
    add_edge_1_indexed(b - 1, a - 1, c)
  end
end
