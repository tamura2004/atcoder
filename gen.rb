N = 2000

open("sample.txt", "w") do |f|
  f.puts "#{N} #{N}"
  N.times do |i|
    cells = N.times.map { ("a".."z").to_a.sample }.to_a
    if i == 0
      cells[0] = "S"
    elsif i == N - 1
      cells[-1] = "G"
    end
    f.puts cells.join
  end
end
