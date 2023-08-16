n = 500000
q = 500000
s = Array.new(n) { [*?a..?z,*?A..?Z].sample }.join

open("sample.txt", "w") do |f|
  f.puts n
  f.puts s
  f.puts q
  q.times do
    t = rand(1..3)
    x = rand(1..n)
    if t != 1
      x = 0
    end
    c = [*?a..?z,*?A..?Z].sample
    f.puts "#{t} #{x} #{c}"
  end
end
