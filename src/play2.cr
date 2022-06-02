module Incrementable
  def inc
    @val += 1
  end
end

class Hoge
  include Incrementable
  getter val : Int32
  def initialize(@val)
  end
end

h = Hoge.new(10)
h.inc
pp h