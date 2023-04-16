require "crystal/modint9"

n,a,b,p,q = gets.to_s.split.map(&.to_i)
st = Hash(Tuple(Int32,Int32), ModInt).new
st[{a,b}] = 1.to_m

t_win = 0.to_m
a_win = 0.to_m

while st.keys.size > 0
  nex = Hash(Tuple(Int32,Int32), ModInt).new(0.to_m)
  st.each do |(aa,bb), pr|
    (1..p).each do |i|
      if aa + i >= n
        t_win += pr // p
      else
        nex[{aa+i, bb}] += pr // p
      end
    end
  end
  st = nex

  nex = Hash(Tuple(Int32,Int32), ModInt).new(0.to_m)
  st.each do |(aa,bb), pr|
    (1..q).each do |i|
      if bb + i >= n
        a_win += pr // q
      else
        nex[{aa, bb+i}] += pr // q
      end
    end
  end
  st = nex
end

pp t_win
