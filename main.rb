# A operation add 100Ag water
# B operation add 100Bg water
# C operation add Cg suger
# D operation add Dg suger
# E Eg suger can dissolve 100g water
# F total weight

A,B,C,D,E,F = gets.split.map(&:to_i)

SugerWater = Struct.new(:a,:b,:c,:d) do
  def weight
    water + suger
  end
  def water
    (a*A + b*B)*100
  end
  def suger
    c*C + d*D
  end
  def key

  def concentration
    suger*100.0 / weight
  end
  def is_dissolved
    water * E > suger * 100
  end
  def is_valid
    is_dissolved && weight <= F
  end
  def values
    [a,b,c,d]
  end
  def candidates
    arr = [
      SugerWater.new(a+1,b,c,d),
      SugerWater.new(a,b+1,c,d),
      SugerWater.new(a,b,c+1,d),
      SugerWater.new(a,b,c,d+1),
    ]
    arr.select(&:is_valid)
  end
end

root = SugerWater.new(0,0,0,0)
Q = [root]

until Q.empty?
  node = Q.shift
  p node.weight
  # if node.weight == 110
  #   puts "gorl"
  #   exit
  # end
  node.candidates.each{ |c| Q.push(c) }
end
