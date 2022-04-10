require "crystal/matrix"

n = gets.to_s.to_i64
st = Array.new(n) do
  a,b,c = gets.to_s.split.map(&.to_i64)
  a = a.to_i - 1
  b = b.to_i - 1
  {a,b,c}
end

m = Matrix(Int64).zero(20)
st.each do |a,b,c|
  chmax m[a][b], c
end

pp m