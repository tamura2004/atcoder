# F2におけるガウス・ジョルダン
class BitMatrix
  DIGIT_SIZE = 64

  getter n : Int32
  getter a : Array(Int64)

  def initialize(a)
    @a = a.map(&.to_i64)
    @n = a.size
  end

  def gauss_jordan
    rank = 0
    DIGIT_SIZE.times do |i|
      if pivot = a.index(rank, &.bit(i).== 1)
        a.swap(rank, pivot)
      else
        next
      end

      n.times do |row|
        next if row == rank
        next if a[row].bit(i) == 0
        a[row] ^= a[rank]
      end

      rank += 1
      break if rank >= n
    end
    rank
  end

  def show
    n.times do |i|
      puts a[i].to_s(2).rjust(8, '0').reverse
    end
  end
end

m = BitMatrix.new([12,22,32,44])
m.gauss_jordan
m.show
