struct Rep
  getter a : Array(Int32)

  def initialize(@a)
  end

  def *(other : self)
    Rep.new(Array(Int32).new(a.size) { |i|
      other[a[i]]
    })
  end

  delegate "[]", to: a
end

a = Rep.new([1, 2, 3, 4, 5, 0])
b = a * a
