# 座標圧縮
#
# ```
# cc = CC.new(src: [100, 20, -10, 20])
# cc.keys # => [-10,20,100]
# cc[-10] # => 0
# cc[20] # => 1
# cc[100] # => 2
# cc[200] #=> raise Exception
# ```
class CC(T)
  getter keys : Array(T)
  getter index : Hash(T, Int32)
  delegate size, to: keys

  def initialize(src : Array(T))
    @keys = src.map{|v|T.new(v)}.sort.uniq
    @index = {} of T => Int32
    keys.each do |key|
      index[key] = keys.bsearch_index(&.>= key).not_nil!
    end
  end

  def [](key)
    index[key]
  end
end

module Indexable(T)
  def to_cc
    CC(T).new(self)
  end
end
