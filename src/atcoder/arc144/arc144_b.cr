require "crystal/balanced_tree/treap/multiset"

st = Multiset(Int64).new
n,x,y = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)

a.each do |v|
  st << v
end

loop do
  mini = st.shift.not_nil!
  maxi = st.pop.not_nil!
  
  unless mini + x < maxi - y
    st << mini
    st << maxi
    break
  end
  
  st << mini + x
  st << maxi - y
end

pp st.min
