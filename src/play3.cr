# crystal 0.33のsortは安定（stable）か

n = 500000
a = Array.new(n) do |i|
  v = rand(10)
  {v, i}
end
a.sort!(&.[0])

(n-1).times do |i|
  if a[i][0] == a[i+1][0] && a[i][1] > a[i+1][1]
    pp! a[i-1..i+2]
    exit
  end
end
