module Indexable(T)
  def cs
    each_with_object([T.zero]) do |v, cs|
      cs << cs.last + v
    end
  end
end

n, x = gets.to_s.split.map(&.to_i64)
a, b = Array.new(n) do
  gets.to_s.split.map(&.to_i64)
end.transpose

csa = a.cs
csb = b.cs

ans = n.times.min_of do |i|
  next Int64::MAX if x < i + 1
  cnt = x - i - 1
  csa[i+1] + csb[i+1] + b[i] * cnt
end

pp ans