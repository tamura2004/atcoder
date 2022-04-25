require "crystal/treap"

enum OP
  REP = 1
  ADD = 2
end

n, k = gets.to_s.split.map(&.to_i64)
a = Array.new(n) do
  t, y = gets.to_s.split.map(&.to_i64)
  {OP.new(t.to_i), y}
end
a.unshift({OP::REP, 0_i64})

st = Treap(Int64).new
ans = Int64::MIN

a.reverse_each do |op, y|
  case op
  when .rep?
    t2, t3 = st.split(0)
    t1, t2 = t2.split_at(k)

    cnt = y + t3.sum + t2.sum

    t2 = t1.merge(t2)
    st = t2.merge(t3)

    chmax ans, cnt

    k -= 1
    break if k < 0
  when .add?
    st << y
  end
end

pp ans
