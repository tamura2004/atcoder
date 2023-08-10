n = gets.to_s.to_i
bag = (1..n*2 + 1).to_set
loop do
  ball = bag.first
  bag.delete(ball)
  puts ball
  STDOUT.flush

  ball = gets.to_s.to_i64
  exit if ball.zero?
  bag.delete(ball)
end
