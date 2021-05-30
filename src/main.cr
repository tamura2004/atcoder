require "crystal/segment_tree"

macro chmin(target, other)
  {{target}} = ({{other}}) if ({{target}}) > ({{other}})
end

n,k = gets.to_s.split.map(&.to_i)
a = Array.new(n){ gets.to_s.split.map(&.to_i64) }

ref = a.flatten.sort.uniq
b = a.map do |aa|
  aa.map do |v|
    ref.bsearch_index do |u|
      v <= u
    end.not_nil!
  end
end

ans = ref.size + 1
kk = (k * k + 1) // 2
sign = 1

i = j = 0
st = SegmentTree(Int32).range_sum_query(ref.size)
k.times do |i|
  k.times do |j|
    st[b[i][j]] += 1
  end
end

loop do
  chmin ans, st.bsearch(kk)

  case
  when i.even? && j < n - k
    k.times do |ii|
      st[b[i+ii][j]] -= 1
      st[b[i+ii][j+k]] += 1
    end
    j += 1
  when i.even? && j == n - k && i < n - k
    k.times do |jj|
      st[b[i][j+jj]] -= 1
      st[b[i+k][j+jj]] += 1
    end
    i += 1
  when i.odd? && j != 0
    j -= 1
    k.times do |ii|
      st[b[i+ii][j]] += 1
      st[b[i+ii][j+k]] -= 1
    end
  when i.odd? && j == 0 && i < n - k
    k.times do |jj|
      st[b[i][j+jj]] -= 1
      st[b[i+k][j+jj]] += 1
    end
    i += 1
  else
    break
  end
end

pp ref[ans]