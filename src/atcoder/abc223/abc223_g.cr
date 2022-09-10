require "crystal/graph"
require "crystal/graph/rerooting"

n = gets.to_s.to_i
g = Graph.new(n)
(n - 1).times { g.read }

rr = Rerooting(Bool).new(
  g,
  f1: ->(a : Bool) { a },
  merge: ->(a : Bool, b : Bool) { a || b },
  unit: false,
  f2: ->(a : Bool) { !a }
)

pp rr.solve.count(true)