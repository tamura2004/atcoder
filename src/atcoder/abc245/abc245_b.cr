require "crystal/neko_set"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
st = a.to_neko_set
pp st.mex