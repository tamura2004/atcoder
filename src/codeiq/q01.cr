require "crystal/bit_set"

1000.upto(9999) do |i|
  rev = i.to_s.chars.reverse.join.to_i
  0b111.subsets.each do |s|
    if rev == calc(i, s)
      puts i
    end
  end
end

def calc(i, s)
  # ビット位置で区切る
  i.to_s.chars.zip(0..).slice_when do |(v,i)|
    s.bit(i) == 1
  end.map(&.map(&.first)).map(&.join.to_i).product
end

