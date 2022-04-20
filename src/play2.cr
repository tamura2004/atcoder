class Outer
  @@x : Int64 = 88172645463325252_i64

  def self.get_outer
    @@x = @@x ^ (@@x << 7)
    @@x = @@x ^ (@@x >> 9)
  end

  class Inner
    getter x : Int64

    def initialize
      @x = Outer.get_outer
    end
  end
end

i = Outer::Inner.new
pp i
