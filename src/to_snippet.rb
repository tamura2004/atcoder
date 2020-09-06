open "snippet.txt", "w" do |fh| 
  DATA.each_line do |line|
    fh.puts line.chomp.inspect + ","
  end
end
__END__
# ModInt
record ModInt, value : Int64 = 0_i64 do
  MOD = 1_000_000_007_i64
  def +(other); ModInt.new((@value + other.to_i64 % MOD) % MOD); end
  def <<(other); ModInt.new((@value << other) % MOD); end
  delegate inspect, to: @value
  delegate to_s, to: @value
  delegate to_i64, to: @value
end