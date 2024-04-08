require "crystal/st"

# 0-[0]-1-[1]-2-[2]-3

n, q = gets.to_s.split.map(&.to_i64)
s = gets.to_s.chars.map(&.to_i)
st = s.each_cons_pair.map{|i,j| (i == j).to_unsafe}.to_a.to_st_sum

pp! st.to_s

q.times do
  cmd, lo, hi = gets.to_s.split.map(&.to_i64)
  case cmd
  when 1
    lo -= 1
    hi -= 1
    if lo > 0
      st[lo-1] = 1 - st[lo-1].not_nil!
    end
    if hi < n - 1
      st[hi+1] = 1 - st[hi+1].not_nil!
    end
  when 2
    lo -= 1
    hi -= 1
    if lo == hi
      puts :Yes
    else
      puts st[lo...hi] == 0 ? :Yes : :No
    end
  end
end
