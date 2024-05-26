require "crystal/lst"

record X, one : Int64, zero : Int64, inv : Int64 do
  def +(y : X) : X
    X.new(one + y.one, zero + y.zero, inv + y.inv + one * y.zero)
  end

  def - : X
    X.new(zero, one, zero * one - inv)
  end

  def *(a : A) : X
    a.val == 1 ? -self : self
  end
end

record A, val : Int64 do
  def +(b : A) : A
    A.new(val ^ b.val)
  end
end

n, q = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
values = a.map do |i|
  X.new(i, 1_i64 - i, 0_i64)
end
st = LST(X,A).new(values)

q.times do
  cmd, l, r = gets.to_s.split.map(&.to_i64)
  l -= 1
  r -= 1
  case cmd
  when 1
    st[l..r] = A.new(1_i64)
  when 2
    puts st[l..r].inv
  end
end