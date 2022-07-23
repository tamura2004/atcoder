class String
  def substrings(n)
    (0..size-n).map do |i|
      self[i...i+n]
    end
  end
end

pp "hoge".substrings(2)

# s = gets.to_s
# t = gets.to_s
# k = gets.to_s.to_i

# ca = Array.new(k) do
#   c, a = gets.to_s.split
#   {a,c}
# end

# g = Hash(String,Array(String)).new{|h,k|h[k] = [] of String}

# q = Deque(String).new([t])
# while q.size > 0
#   v = q.shift
