require "numo/narray"
require "numo/gnuplot"

gp = Numo::Gnuplot.new
gp.set title: "example"
gp.plot "sin(x)", w: "lines"
