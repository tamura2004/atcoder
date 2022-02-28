# この後で最初に登場するindex
def ix_after(s)
  ans = Array.new(s.size) { Array.new(26, nil.as(Int32?)) }
  s.chars.zip(0..).reverse_each do |c, i|
    if i < s.size - 1
      26.times do |j|
        ans[i][j] = ans[i + 1][j]
      end
    end

    ans[i][c.ord - 'a'.ord] = i
  end
  ans
end

# 候補
def candi(s)
  ix = ix_after(s)

  s.chars.each_index do |i|
    pre = s[0...i]

    26.times do |j|
      next if ix[i][j].nil?

      yield pre + (j + 'a'.ord).chr
    end
  end
end

# main
n = gets.to_s.to_i
ss = Array.new(n) do
  gets.to_s
end.sort_by(&.size).reverse.map(&.reverse)

tr = Hash(String,Int64).new(0_i64)
ans = 0_i64

ss.each do |s|
  ans += tr[s]
  candi(s) do |cs|
    tr[cs] += 1
  end
end
pp ans
