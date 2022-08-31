# alias V = Tuple(Int32,Int32)
# alias E = NamedTuple(cost: Int64, color: Int32)

class Hoge
  def each
    10.times do |i|
      yield i
    end
  end
end

Hoge.new.each do |i|
  pp i
  break if i == 5
end
