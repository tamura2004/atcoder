H,W,A,B = gets.split.map(&:to_i)

S = A * H
case S / W
when 0..B
