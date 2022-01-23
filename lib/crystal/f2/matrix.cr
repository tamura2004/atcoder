module F2
  class Matrix(T)
    getter h : Int32
    getter w : Int32
    getter a : Array(T)
    delegate "[]", pop, size, empty?, to: a

    def initialize(@w)
      @h = 0
      @a = [] of T
    end
    
    def initialize(@a, @w)
      @h = a.size
    end

    def <<(r)
      a << r
      @h += 1
    end

    def +(r)
      Matrix(T).new(@a.dup + [r], @w)
    end

    # 掃き出し法により正規形へ
    def solve
      row = 0
      w.times do |i|
        row.upto(h-1) do |j|
          next if a[j].bit(i) == 0
          a.swap row, j
          h.times do |j|
            next if row == j
            a[j] ^= a[row] if a[j].bit(i) == 1
          end
          row += 1
          break
        end
      end
      self
    end

    # 解の個数は、2 ** free
    def free
      a.count(&.zero?)
    end

    def rank
      h - free
    end

    # vによる剰余空間
    def -(v)
      w.times do |i|
        next if v.bit(i) == 0
        h.times do |j|
          a[j] ^= v if a[j].bit(i) == 1
        end
        break
      end
      self
    end

    # ベクトル空間に含まれるか
    def includes?(v)
      x = 0
      h.times do |y|
        while x < w && a[y].bit(x).zero?
          x += 1
        end
        break unless x < w
        next if v.bit(x).zero?
        v ^= a[y]
      end
      v.zero?
    end

    def debug
      puts "==DEBUG=="
      h.times do |i|
        case a[i]
        when Number
          puts ("%0#{w}b" % a[i]).reverse
        else
          puts a[i].to_s
        end
      end
    end
  end
end
