yoko = ('a'..'h').to_a
tate = ('1'..'8').to_a

s = Array.new(8){gets.to_s}.reverse
8.times do |i|
  8.times do |j|
    if s[i][j] == '*'
      puts [yoko[j], tate[i]].join
      exit
    end
  end
end
