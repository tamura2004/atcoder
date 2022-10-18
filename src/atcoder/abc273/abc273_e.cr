class PStack
  getter pr : PStack?
  getter val : Int32

  def initialize(@pr = nil, @val = -1)
  end

  def push(x)
    self.class.new(self, x)
  end

  def pop : PStack
    ret = pr
    ret || self
  end

  def top
    val
  end
end

note = Hash(Int32,PStack).new do |h,k|
  h[k] = PStack.new
end

a = PStack.new

q = gets.to_s.to_i64
ans = [] of Int32
q.times do
  cmd, x = gets.to_s.split + ["-1"]
  x = x.to_i

  case cmd
  when "ADD"
    a = a.push(x)
  when "DELETE"
    a = a.pop
  when "SAVE"
    note[x] = a
  when "LOAD"
    a = note[x]
  end

  ans << a.top
end

puts ans.join(" ")


