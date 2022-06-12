class CumulativeSum(T)
  getter a : Array(T)
  getter cs : Array(T)
  getter n : Int32

  def initialize(@a)
    a.sort!
    @n = a.size
    @cs = [T.zero]
    a.each { |ai| cs << cs.last + ai }
  end

  def count_upper(x : T)
    n - (a.bsearch_index(&.>= x) || n)
  end

  def count_lower(x : T)
    a.bsearch_index(&.> x) || n
  end

  def sum_upper(x : T)
    i = a.bsearch_index(&.>= x) || n
    cs[-1] - cs[i]
  end

  def sum_lower(x : T)
    i = a.bsearch_index(&.> x) || n
    cs[i]
  end
end

alias CS = CumulativeSum

n,q = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
tr = CS(Int64).new(a)

q.times do
  x = gets.to_s.to_i64

  c_hi = tr.count_upper(x)
  s_hi = tr.sum_upper(x)

  c_lo = tr.count_lower(x)
  s_lo = tr.sum_lower(x)

  ans = x * (c_lo - c_hi) + s_hi - s_lo
  pp ans
end