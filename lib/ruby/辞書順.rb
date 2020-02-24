S = gets.chomp
N = S.size
if N < 26
  puts S + ([*?a..?z] - S.chars).first
else
  (N-1).downto(0) do |i|
    c = S[i]
    next_c = (c.succ..?z).find do |d|
      !S[0..i][d]
    end
    if next_c
      puts S[0...i] + next_c
      exit
    end
  end
  puts -1
end

