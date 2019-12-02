N = gets.to_i
S = gets.chomp.chars.map &:to_i
count = 0

10.times do |i|
  10.times do |j|
    10.times do |k|
      ix = S.index(i)
      next unless ix

      s = S[ix+1,S.size-ix+1]
      iy = s.index(j)
      next unless iy

      s = s[iy+1,s.size-iy+1]
      iz = s.index(k)
      next unless iz

      count += 1
    end
  end
end

p count
