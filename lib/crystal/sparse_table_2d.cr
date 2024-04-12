class SparseTable2D(T)
  getter h : Int32
  getter w : Int32
  getter a : Array(Array(T))
  getter dp : Array(Array(Array(Array(T?))))
  getter f : Proc(T?, T?, T?)

  def initialize(@a : Array(Array(T)), f : Proc(T, T, T))
    @h = a.size
    @w = a.first.size
    hh = Math.ilogb(Math.pw2ceil(h)) + 1
    ww = Math.ilogb(Math.pw2ceil(w)) + 1
    @dp = Array.new(h) { Array.new(w) { Array.new(hh) { Array.new(ww, nil.as(T?)) } } }
    h.times do |y|
      w.times do |x|
        dp[y][x][0][0] = a[y][x]
      end
    end
    @f = -> (x : T? , y : T?) {
      x && y ? f.call(x, y) : x ? x : y
    }
  end
end
