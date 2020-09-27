class Hoge(T)
  def hi
    puts T.add(10,20)
  end
end

module Fuga
  extend self
  @[AlwaysInline]
  def add(a,b)
    a - b
  end
end

Hoge(Fuga).new.hi