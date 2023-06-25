n = gets.to_s.to_i64
s = gets.to_s.chars

ans = [] of Char
bgn = [] of Int32 # "("の開始位置

s.each do |c|
  case c
  when '('
    bgn << ans.size
    ans << c
  when ')'
    if bgn.empty?
      ans << c
    else
      i = bgn.pop
      while i < ans.size
        ans.pop
      end
    end
  else
    ans << c
  end
end

puts ans.join