class Hoge
  def []=(a,b,c)
    pp! [a,b,c]
  end
end

Hoge.new[1,2] = 3