require "crystal/segment_tree"

# 主客転倒
# MEXそれぞれの文字をSTに持つと、Eに注目すると、左右のM,Xの組みで

mex = [0, 1, 2].repeated_permutations(3).map do |a|
  case
  when !0.in?(a) then {a, 0}
  when !1.in?(a) then {a, 1}
  when !2.in?(a) then {a, 2}
  else                {a, 3}
  end
end.to_h
# pp mex

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
s = gets.to_s.chars

# {文字,数字} => セグメント木

st = Hash(Tuple(Char, Int32), ST(Int64)).new
3.times do |i|
  "MEX".chars.each do |c|
    st[{c, i}] = n.to_st_sum
  end
end

n.times do |i|
  c = s[i]
  j = a[i]
  st[{c, j}][i] += 1
end

# pp! st[{'M', 1}][..2]
# pp! st[{'X', 2}][2..]
# pp! mex[[1,0,2]]

ans = 0_i64
n.times do |i|
  next unless s[i] == 'E'

  3.times do |lo|
    3.times do |hi|
      left = st[{'M', lo}][..i]
      next if left == 0
      right = st[{'X', hi}][i..]
      next if right == 0
      key = [lo, a[i], hi]
      m = mex[key]
      # pp! [i, lo, hi, left, right, key, m]
      ans += left * right * m
    end
  end
end

pp ans
