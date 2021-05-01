class Counter
  getter h : Hash(Int32,Int32)
  getter size : Int32
  delegate "[]", to: h

  def initialize
    @h = Hash(Int32,Int32).new(0)
    @size = 0
  end

  def []=(i, v)
    @size += 1 if h[i] == 0
    h[i] = v
    @size -= 1 if h[i] == 0
  end
end

macro chmin(target, other)
  {{target}} = ({{other}}) if ({{target}}) > ({{other}})
end

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i)
m = a.uniq.size

hi = 0
cnt = Counter.new
ans = 10**6

n.times do |lo|
  while hi < n && cnt.size < m
    cnt[a[hi]] += 1
    hi += 1
  end

  chmin ans, hi - lo if hi - lo == m

  cnt[a[lo]] -= 1
end

pp ans
