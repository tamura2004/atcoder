# 基準高さ付きハッシュ
# ```
# ds = DiffHash.new
# ds[10] = 100
# ds.up 5
# ds[10] # => 0
# ds[5] # => 100
# ds[10] = 200
# ds.down 3
# ds[8] # => 100
# ds[13] # => 200
# ```
class DiffHash
  getter hash : Hash(Int32,Int64)
  getter height : Int32
  delegate empty, to: hash

  def initialize
    @hash = Hash(Int32,Int64).new(0_i64)
    @height = 0
  end

  def []=(key, value)
    key = key.to_i
    value = value.to_i64
    
    hash[key + height] = value
  end
  
  def [](key)
    key = key.to_i
    hash[key + height]
  end

  def up(h)
    @height += h
  end

  def down(h)
    @height -= h
  end
end
