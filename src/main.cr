class Problem
  getter g : Graph
  delegate n, to: g

  def initialize(@g)
  end
end
