require "set"

n = gets.to_i
bag = (1..n * 2 + 1).to_set
loop do
  ball = bag.first
  bag.delete(ball)
  puts ball
  STDOUT.flush

  ball = gets.to_i
  exit if ball.zero?
  bag.delete(ball)
end
