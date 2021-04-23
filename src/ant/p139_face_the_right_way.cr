require "crystal/segment_tree"

n = 7
a = "BBBFBBB".chars.map{|v| v == 'B' ? 1 : 0}

minm = 10**6
mink = 10**6

7.downto(1) do |k|
  if m = paint?(a,k)
    if m <= minm
      minm = m
      mink = k
    end
  end
end

puts "#{minm} #{mink}"

def paint?(a,k)
  n = a.size
  st = SegmentTree(Int32).new(n)
  m = 0
  n.times do |i|
    lo = Math.max 0, i - k + 1
    if (st[lo..i] + a[i]).odd?
      return nil if n < i + k
      st[i] = 1
      m += 1
    end
  end
  m
end
