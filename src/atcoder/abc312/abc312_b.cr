h, w = gets.to_s.split.map(&.to_i)
s = Array.new(h) do
  gets.to_s.chars.map { |c| c == '#' ? 1 : 0 }
end

is_tak = ->(y : Int32, x : Int32) {
  return false if h < y + 9 || w < x + 9

  3.times do |i|
    3.times do |j|
      return false if s[y + i][x + j] == 0
      return false if s[y + i + 6][x + j + 6] == 0
    end
  end

  4.times do |i|
    return false if s[y + 3][x + i] == 1
    return false if s[y + 5][x + i + 5] == 1
    return false if s[y + i][x + 3] == 1
    return false if s[y + i + 5][x + 5] == 1
  end

  return true
}

h.times do |ii|
  w.times do |jj|
    if is_tak.call(ii, jj)
      puts "#{ii.succ} #{jj.succ}"
    end
  end
end
