struct Range(B, E)
  def merge(b : self) : self?
    return nil if b.end < @begin || @end < b.begin
    Math.min(@begin, b.begin)..Math.max(@end, b.end)
  end
end

class RangeSet(T)
  getter s : Set(Range(T,T))

  def initialize
    @s = Set(Range(T,T)).new
  end

  def <<(b : Range(T,T))
    s.each do |a|
      if res = b.merge(a)
        s.delete(a)
        b = res
      end
    end
    s << b
  end

  def size
    s.sum do |r|
      T.new(r.size)
    end
  end
end
