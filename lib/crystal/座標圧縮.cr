a = Array.new(5){ rand 1..100 }
p a
p a.zip(1..).sort.map(&.last).zip(1..).sort.map(&.last)

