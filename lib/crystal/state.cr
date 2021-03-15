macro state(name, *xs)
  struct {{name.id}}
    include Comparable({{name.id}})

    {% for x in xs %}
      getter {{x}}
    {% end %}

    def initialize({{ *xs.map { |f| "@#{f}".id } }})
    end

    def make({{ *xs.map { |f| "#{f} = #{f.var}".id } }})
      self.class.new({{ *xs.map(&.var.id) }})
    end

    def key
      Tuple.new({{ *xs.map(&.var.id) }})
    end

    def <=>(b : self)
      key <=> b.key
    end

    def_equals_and_hash key

    {{yield}}
  end
end

state State, x : Int32, y : Int32

a = State.new(10, 20)
pp! a.make(x: 30)

# struct State
#   include Comparable(State)
#   getter x : Int64
#   getter y : Int64

#   def initialize(@x : Int64, @y : Int64)
#   end

#   def make(x = x, y = y)
#     Pos.new(x, y)
#   end

#   def key
#     {x, y}
#   end

#   def <=>(b : self)
#     key <=> b.key
#   end

#   def_equals_and_hash key
# end
