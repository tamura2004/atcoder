macro make_array(i,v)
  Array.new({{i}}){ {{v}} }
end

macro make_array(i,j,v)
  Array.new({{i}}){ Array.new({{j}}){ {{v}} } }
end

macro make_array(i,j,k,v)
  Array.new({{i}}){ Array.new({{j}}){ Array.new({{k}}){ {{v}} } } }
end

macro make_array(i,j,k,l,v)
  Array.new({{i}}){ Array.new({{j}}){ Array.new({{k}}){ Array.new({{l}}){ {{v}} } } } }
end

pp! make_array(3,0)
pp! make_array(3,3,0)
pp! make_array(3,3,3,0)
pp! make_array(3,3,3,3,0)