module Enumerable(T)
  def tally
    each_with_object(Hash(T,Int64).new(0_i64)) do |v,h|
      h[v] += 1
    end
  end
end
