struct Range(B, E)
  def merge(b : self) : self?
    return nil if b.end < @begin || @end < b.begin
    Math.min(@begin, b.begin)..Math.max(@end, b.end)
  end

  def &(b : self) : self
    Math.max(@begin, b.begin)..Math.min(@end, b.end)
  end

  def widen
    empty? ? self : (@begin - 1)..(@end + 1)
  end

  def empty?
    @begin > @end
  end
end

class RangeSet(T)
  getter s : Set(Range(T,T))

  def initializ
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