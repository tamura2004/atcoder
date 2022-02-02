LIMIT = 20_i64

record LNum, v : Int64 do
  def +(b : self); LNum.new Math.min(LIMIT, v + b.v); end
  def self.zero; LNum.new(0); end
end

a = LNum.new 100
b = LNum.zero

pp a + b
