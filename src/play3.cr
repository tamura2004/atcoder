require "complex"

def to_complex_set(s)
  ans = Set(Complex).new
  s.each_with_index do |r, i|
    r.each_with_index do |c, j|
      ans << Complex.new(j, i) if c == '#'
    end
  end
  ans
end

def left_just(s)
  offset = s.map(&.real).min
  s.map(&.- offset).to_set
end

def top_just(s)
  offset = s.map(&.imag).min
  s.map(&.- Complex.new(0, offset)).to_set
end

def rot90(s)
  s.map(&.* Complex.new(0, 1)).to_set
end

n = gets.to_s.to_i64
s = to_complex_set Array.new(n){ gets.to_s.chars }
t = to_complex_set Array.new(n){ gets.to_s.chars }

t = left_just(top_just(t))
4.times do
  s = left_just(top_just(s))
  if s == t
    puts "Yes"
    exit
  end

  s = rot90(s)
end

puts "No"
