class BitVector
  getter n : Int32                    # bitサイズ
  getter m : Int32                    # chunkサイズ
  getter bit : Array(UInt32)          # 元データ
  getter chunk : Array(Int32)         # チャンク
  getter blocks : Array(Array(Int32)) # ブロック

  def initialize(@n)
    @m = (n + 1023) >> 10
    @bit = Array.new((n + 1023 >> 10) << 10, 0u32)
    @chunk = Array.new(m + 1, 0)
    @blocks = Array.new(m) { Array.new(32, 0) }
  end

  # i桁目を1にする
  def set(i)
    bit[i >> 5] |= 1u32 << (i & 31)
  end

  # i桁目のbit
  def access(i)
    bit[i >> 5].bit(i & 31)
  end

  # 前計算
  def build
    m.times do |i|
      31.times do |j|
        blocks[i][j + 1] = blocks[i][j] + bit[(i << 5) + j].popcount
      end
      chunk[i + 1] = chunk[i] + blocks[i][-1] + bit[(i << 5) + 31].popcount
    end
  end

  # [0,i)の1の数
  def rank(i)
    chunk_rank(i) + blocks_rank(i) + bit_rank(i)
  end

  # rank(i) = xなる最小のiを返す
  def select(x)
    (0..n).bsearch { |i| x <= rank(i) }
  end

  @[AlwaysInline]
  private def chunk_rank(i)
    chunk[i >> 10]
  end
  
  @[AlwaysInline]
  private def blocks_rank(i)
    blocks[i >> 10][(i >> 5) & 31]
  end
  
  @[AlwaysInline]
  private def bit_rank(i)
    bit[i >> 5].bits(0..(i & 31)).popcount
  end

end
