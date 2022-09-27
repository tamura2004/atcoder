# query = -> (x : Int32) do
#   x * x > 1000
# end

def query(x)
  x * x > 1000
end

# q = ->query(Int32)

pp (0...1000).bsearch(&->query(Int32))