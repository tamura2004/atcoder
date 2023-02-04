# sの部分列としてtが何文字含まれるか
class Subseq(T)
  getter s : Array(T)
  getter n : Int32
  getter idx : Hash(T, Array(Int32))

  def initialize(@s)
    @n = s.size
    @idx = Hash(T, Array(Int32)).new do |h, k|
      h[k] = Array.new(n+1, -1)
    end
    (0...n).reverse_each do |i|
      idx.keys.each do |key|
        idx[key][i] = idx[key][i+1]
      end
      idx[s[i]][i] = i
    end
  end

  def solve(t : Array(T))
    pos = 0
    t.each_with_index do |c, i|
      pos = idx[c][pos]
      return i if pos == -1
      pos += 1
    end
    return t.size
  end

  def self.calc(len, left, right)
    lo = len - right
    hi = left
    return -1 unless lo <= hi
    return (lo..hi).min_of do |i|
      (len - i * 2).abs
    end
  end
end

s = gets.to_s.chars
t = gets.to_s.chars.reverse
ss = Subseq(Char).new(s)
st = Subseq(Char).new(t)
n = gets.to_s.to_i
n.times do |i|
  a = gets.to_s.chars
  b = a.reverse
  left = ss.solve(a)
  right = st.solve(b)
  if left == 0 || right == 0
    pp -1
  else
    pp Subseq.calc(a.size, left, right)
  end
end
