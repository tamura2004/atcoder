# 容量Tを持つ辺
class Edge(T)
  getter v : Int32
  getter re : Int32
  property cap : T

  def initialize(@v, @re, @cap)
  end
end

e = Edge(Int64).new(1,2,1000000000000)
{% for v in %w(v re cap) %}
  {{v.id}} = e.{{v.id}}
{% end %}
pp! v.class
pp! re.class
pp! typeof(cap)
