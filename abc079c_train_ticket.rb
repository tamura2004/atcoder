A = gets.chomp.chars.map(&:to_i)
OP = %w(+ -).repeated_permutation(3).to_a

OP.each do |op|
  exp = A.zip(op).flatten.compact.join
  ans = eval(exp)
  if ans == 7
    puts exp + "=7"
    exit
  end
end
