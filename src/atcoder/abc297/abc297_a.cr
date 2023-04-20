s = gets.to_s.chars
cnt = Hash(Char,Array(Int32)).new{|h,k|h[k] = [] of Int32}
s.each_with_index do |c,i|
  cnt[c] << i
end

quit :No if cnt['B'].map(&.odd?.to_unsafe).sum.even?
quit :No unless cnt['R'][0] < cnt['K'][0] < cnt['R'][1]
puts :Yes

