N = 400

open("src/input.txt", "w") do |f|
  f.puts [N,N].join(" ")
  N.times do |i|
    f.puts Array.new(N){ %w(# .).sample }.join
  end
end
