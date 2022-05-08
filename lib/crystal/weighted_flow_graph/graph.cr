module WeightedFlowGraph
  class Edge
    getter to : Int32
    property rev : Int32
    property cap : Int64
    property cost : Int64
  
    def initialize(@to, @rev, @cap, @cost)
    end
  
    def inspect(io)
      io << "{to: #{@to}, rev: #{@rev}, cap: #{@cap}, cost: #{@cost}}"
    end
  end
  
  class Graph
    getter n : Int32
    getter g : Array(Array(Edge))
    getter pos : Array(Tuple(Int32, Int32))
    delegate "[]", to: g
  
    
    def initialize(n)
      @n = n.to_i
      @pos = [] of Tuple(Int32, Int32)
      @g = Array(Array(Edge)).new(@n) { [] of Edge }
    end
    
    def add(v, nv, cap, cost, origin = 0) : Int32
      v = v.to_i - origin
      nv = nv.to_i - origin
      cap = cap.to_i64
      cost = cost.to_i64

      edge_number = pos.size
      pos << {v, g[v].size}
      
      rev_v = g[v].size
      rev_nv = g[nv].size
      rev_nv += 1 if v == nv

      g[v] << Edge.new(nv, rev_nv, cap, cost)
      g[nv] << Edge.new(v, rev_v, 0i64, -cost)
      
      edge_number
    end
    
    def get_edge(i)
      _e = g[pos[i][0]][pos[i][1]]
      _re = g[_e.to][_e.rev]
      {pos[i][0], _e.to, _e.cap + _re.cap, _re.cap, _e.cost}
    end
    
    def edges
      pos.map do |(from, id)|
        _e = g[from][id]
        _re = g[_e.to][_e.rev]
        {from, _e.to, _e.cap + _re.cap, _re.cap, _e.cost}
      end
    end

    def debug(origin = 0)
      File.open("debug.dot", "w") do |fh|
        fh.puts "digraph tree {"
        edges.each do |v, nv, cap, flow, cost|
          v += origin
          nv += origin
          fh.puts "#{v} -> #{nv} [label=\"#{cap}[#{flow}],#{cost}\"]"
        end
        fh.puts "}"
      end
      puts `cat debug.dot | graph-easy --from=dot --as_ascii`
    end
  end
end
