module F2
  class Matrix(T)
    getter a : Array(T)
    delegate "[]", pop, size, empty?, to: a

    def initialize(@a)
    end

    def n
      a.size
    end


    def sweep
      row = 0
      60.times do |i|
        row.upto(n-1) do |j|
          next if a[j].bit(i) == 0
          a.swap row, j
          n.times do |j|
            next if row == j
            a[j] ^= a[row] if a[j].bit(i) == 1
          end
          row += 1
          break
        end
      end
    end

    # vの剰余空間
    def -(v)
      60.times do |i|
        next if v.bit(i) == 0
        n.times do |j|
          a[j] ^= v if a[j].bit(i) == 1
        end
        break
      end
      self
    end

    def debug(d = 60)
      puts "==DEBUG=="
      n.times do |i|
        puts ("%0#{d}b" % a[i]).reverse
      end
    end
  end
end
