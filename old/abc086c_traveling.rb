N = gets.to_i
A = Array.new(N){gets.split.map(&:to_i)}
A.unshift([0,0,0])

ans = true
A.each_cons(2) do |a1,a2|
  dt = a2[0] - a1[0]
  dx = (a2[1] - a1[1]).abs
  dy = (a2[2] - a1[2]).abs
  dl = dx + dy
  if dl <= dt && (dt - dl).even?
  else
    ans = false
  end
end

puts ans ? "Yes" : "No"
