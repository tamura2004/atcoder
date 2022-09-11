# パターンの最大値は2e6程度

n, m = gets.to_s.split.map(&.to_i)
s = Array.new(n) { gets.to_s }
t = Array.new(m) { gets.to_s }
slen = s.sum(&.size)
gaplen = 16 - slen - (n - 1)
dict = t.to_set

if n == 1
  if !s[0].in?(dict) && 3 <= s[0].size <= 16
    quit s[0]
  else
    quit -1
  end
end

gap = [1] * (n-1)

make_string = -> (a : Array(Int32)) do
  str = ""
  a.each_with_index do |v, i|
    str += s[v]
    str += "_" * gap[i] if i != n - 1
  end
  str
end

# 間隔の列挙
dfs = uninitialized (Int32, Array(Int32)) -> Nil
dfs = -> (rest : Int32, a : Array(Int32)) do
  # pp gap
  # cnt += 1
  str = make_string.call(a)
  if !str.in?(dict)
    quit str
  end

  if rest > 0
    (n-1).times do |i|
      gap[i] += 1
      dfs.call(rest - 1, a)
      gap[i] -= 1
    end
  end
end

(0...n).to_a.each_permutation do |a|
  dfs.call(gaplen, a)
end

pp -1
