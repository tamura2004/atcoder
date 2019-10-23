N,C,K = gets.split.map(&:to_i)
T = Array.new(N){gets.to_i}.sort

Bus = Struct.new(:c, :t) do
  def inc
    self.c += 1
  end
  def valid(tt)
    tt <= t + K && c < C
  end
  def new(tt)
    self.t = tt
    self.c = 0
  end
end

bus = Bus.new(C, -K) # ダミーの満員バス、誰も乗れない
count = 0
T.each do |t|
  if bus.valid(t)
    bus.inc
  else
    bus = Bus.new(1, t)
    count += 1
  end
end
puts count
