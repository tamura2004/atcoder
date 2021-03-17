class Cake
  getter h : Int32
  getter w : Int32
  getter rows : Array(Int32)
  getter cols : Array(Array(Int32))

  def initialize
    @h = 5
    @w = 5
    @rows = [0,2,3,5]
    @cols = [[0,2,3,5],[0,5],[0,3,5]]
  end

  def print
    no = 1
    rows.each_cons(2).with_index do |(cs,ce),i|
      (cs...ce).each do
        buf = [] of Int32
        cols[i].each_cons(2).with_index do |(rs,re),j|
          (rs...re).each do
            buf << no + j
          end
        end
        puts buf.join(" ")
      end
      no += cols[i].size - 1
    end
  end
end

Cake.new.print
