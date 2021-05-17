class CCL
  getter a : Array(Int64)
  getter ready : Bool

  def initialize
    @a = [] of Int64
    @ready = false
  end

  def <<(x : Int)
    raise "already commited" if ready
    a << x.to_i64
  end

  def <<(xs : Array(Int))
    xs.each do |x|
      a << x.to_i64
    end
  end

  def [](x : Int)
    commit! unless ready
    a.bsearch_index do |v|
      x <= v
    end.not_nil!
  end

  def [](xs : Array(Int))
    xs.map do |x|
      self[x]
    end
  end

  private def commit!
    a.sort!.uniq!
    @ready = true
  end
end

w = 10
h = 10
x1 = [1,1,4,9,10]
x2 = [6,10,4,9,10]
y1 = [4,8,1,1,6]
y2 = [4,8,10,5,10]

cx = CCL.new
cy = CCL.new

[x1,x2].each do |xs|
  cx << xs
  cx << xs.map(&.+ 1)
end

[y1,y2].each do |ys|
  cy << ys
  cy << ys.map(&.+ 1)
end

pp! cx[[1,4,6,9]]
