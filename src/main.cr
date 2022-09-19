class Hoge
  getter n : Int32

  def initialize(@n)
  end

  private class TimesIterator
    include Iterator(Int32)
    
    @n : Int32
    @index : Int32

    def initialize(@n : Int32, @index = 0)
    end

    def next
      if @index < @n
        ret = @index
        @index += 1
        ret
      else
        stop
      end
    end
  end

  def times
    TimesIterator.new(n)
  end
end

hoge = Hoge.new(10)
hoge.times.each do |i|
  pp i
end



