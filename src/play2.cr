class Hoge
  def nilhoge
    nil.as(Hoge?)
  end
end

class Fuga < Hoge
end

class Moga
  getter fuga : Fuga?

  def initialize
    @fuga = nilhoge
  end
end

m = Moga.new
