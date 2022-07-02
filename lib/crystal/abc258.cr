module Abc258
  struct A
    getter n : Int32
    getter a : Array(Int32)

    def initialize(@n,@a)
    end

    def solve
      a.sum / n
    end
  end
end
