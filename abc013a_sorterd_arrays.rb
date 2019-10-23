N = gets.to_i
A = gets.split.map(&:to_i)

count = 1
prev = nil

A.each_cons(2) do |a,b|
  if prev.nil? || prev.zero?
    prev = a <=> b
    next
  end

  dir = a <=> b
  if dir.zero? || dir == prev
    next
  end

  count += 1
  prev = nil
end

puts count
