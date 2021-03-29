class Array
  def count_less_or_equal(u)
    bsearch_index do |v|
      u < v
    end || size
  end
end

n, k = gets.to_s.split.map { |v| v.to_i }
a = gets.to_s.split.map { |v| v.to_i }.sort
b = gets.to_s.split.map { |v| v.to_i }.sort

# 小さいほうからk番目 ->
# 「x以下の個数がk以上あるか」のxの最小値

lo = 0
hi = 10 ** 18

ans = (lo..hi).bsearch do |x|
  cnt = a.sum do |v|
    b.count_less_or_equal(x / v)
  end
  k <= cnt
end

pp ans
