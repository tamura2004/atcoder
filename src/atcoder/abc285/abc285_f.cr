require "crystal/segment_tree"

n = gets.to_s.to_i
a = gets.to_s.chars.map(&.ord.- 'a'.ord)
st = Array.new(26) { n.to_st_sum }
a.each_with_index do |v, i|
  st[v][i] = 1_i64
end

ordered = -> (lo : Int32, hi : Int32) do
  cnt = (0...26).map do |i|
    st[i][lo..hi]
  end
  k = 0
  cnt.each_with_index do |v, i|
    return false if st[i][lo+k...lo+k+v] != cnt[i]
    k += v
  end
  return true
end

q = gets.to_s.to_i
q.times do
  cmd, x, y = gets.to_s.split
  case cmd
  when "1"
    x = x.to_i.pred
    c = y[0].ord - 'a'.ord
    i = a[x]
    st[i][x] = 0_i64
    st[c][x] = 1_i64
    a[x] = c
  when "2"
    lo = x.to_i.pred
    hi = y.to_i.pred
    if !ordered.call(lo,hi)
      puts "No"
    else
      mini = a[lo]
      maxi = a[hi]
      if maxi - mini <= 1
        puts "Yes"
      else
        flag = (mini.succ...maxi).all? do |i|
          st[i][lo..hi] == st[i][...n]
        end
        if flag
          puts "Yes"
        else
          puts "No"
        end
      end
    end
  end
end
