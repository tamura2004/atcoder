A = gets.split.map &:to_i
B = gets.split.map &:to_i

patterns = [
  [0,1,2],
  [0,2,1],
  [2,1,0],
  [1,0,2],
  [2,0,1],
  [1,2,0],
]

ans = 0
patterns.each do |pattern|
  c = 3.times.map{|i|B[pattern[i]]}
  cnt = 3.times.inject(1) do |acc,i|
    acc *= A[i] / c[i]
  end
  ans = cnt if ans < cnt
end

puts ans
