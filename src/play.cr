struct Range(B,E)
  def &(b : self) : self
    Math.max(@begin, b.begin)..Math.min(@end, b.end)
  end
end

a = 1..10
b = 8..13
c = 12..14

pp (1..100) & (20..10)
pp (1..100).includes? 20