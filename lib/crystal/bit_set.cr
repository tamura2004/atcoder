# 集合のbit表現のためのInt拡張
{% for t in ["Int", "UInt"] %}
  {% for n in [8, 16, 32, 64, 128] %}
    struct {{t.id}}{{n}}

      # 集合要素の列挙
      #
      # ```
      # 0b101.bit_index.to_a #=> [0, 2]
      # ```
      def elements
        BitElementsIterator.new(self)
      end

      def each_index
        elements.each do |i|
          yield i
        end
      end

      # 集合の要素の列挙イテレータ
      private class BitElementsIterator
        include Iterator({{t.id}}{{n}})
        getter v : {{t.id}}{{n}}
        getter i : Int32

        def initialize(@v)
          @i = 0
        end

        def next
          while i < {{n}} && v.bit(i) == 0
            @i += 1
          end

          if i < {{n}}
            begin i ensure @i += 1 end
          else
            stop
          end
        end
      end
      
      # 集合の真部分集合の列挙
      # 自身と空集合を含む
      #
      # ```
      # 0b101.subsets.to_a #=> [0b101, 0b100, 0b001, 0b000]
      # ```
      def subsets
        SubsetIterator.new(self)
      end

      def each_subset
        SubsetIterator.new(self).each do |t|
          yield t
        end
      end

      private struct SubsetIterator
        include Iterator({{t.id}}{{n}})
        getter s : {{t.id}}{{n}}
        getter t : {{t.id}}{{n}}
        getter halt : Bool

        def initialize(@s)
          @t = s
          @halt = false
        end

        def next
          begin
            halt ? stop : t
          ensure
            @t = (t - 1) & s
            @halt = t == s
          end
        end
      end

      # 自身をインデックスとする参照
      #
      # ```
      # a = [7,3,1]
      # [0,2].map(&.of a) #=> [7, 1]
      # ```
      def of(a)
        a[self]
      end
      
    end
  {% end %}
{% end %}


#   # 部分集合の列挙
#   #
#   # ```
#   # SubsetIterator.new(3).map(&.to_bit(2)).to_a # => ["11","10","01"]
#   # ```
#   private class SubsetIterator
#     include Iterator(Int64)
#     getter v : Int64
#     getter b : Int64

#     def initialize(v)
#       @v = v.to_i64
#       @b = @v
#     end

#     def next
#       if b > 0
#         begin b ensure @b = (b - 1) & v end
#       else
#         stop
#       end
#     end
#   end

#   # 真部分集合の列挙
#   #
#   # ```
#   # ProperSubsetIterator.new(3).map(&.to_bit(2)).to_a # => ["11","10","01"]
#   # ```
#   private class ProperSubsetIterator
#     include Iterator(Int64)
#     getter v : Int64
#     getter b : Int64

#     def initialize(v)
#       @v = v.to_i64
#       @b = @v
#     end

#     def next
#       @b = (b - 1) & v
#       if b > 0
#         b
#       else
#         stop
#       end
#     end
#   end

#   # サイズKの部分集合の列挙
#   #
#   # ```
#   # FixSizeSubsetIterator.new(3, 2).map(&.to_bit(3)).to_a # => ["011","101","110"]
#   # ```
#   private class FixSizeSubsetIterator
#     include Iterator(Int64)
#     getter n : Int64
#     getter k : Int64
#     getter b : Int64

#     def initialize(@n, @k)
#       @b = (1_i64 << k) - 1
#     end

#     def next
#       if b < (1 << n)
#         begin
#           b
#         ensure
#           x = b & -b
#           y = b + x
#           @b = ((b & ~y) // x >> 1) | y
#         end
#       else
#         stop
#       end
#     end
#   end

#   # 集合の要素の列挙
#   #
#   # ```
#   # BitIndex.new(10).to_a # => [1, 3]
#   # ```
#   private class BitIndex
#     include Iterator(Int32)
#     getter v : Int64
#     getter i : Int32

#     def initialize(v)
#       @v = v.to_i64
#       @i = 0
#     end

#     def next
#       while (1_i64 << i) <= v && v.bit(i) == 0
#         @i += 1
#       end
#       if (1_i64 << i) > v
#         stop
#       else
#         begin i ensure @i += 1 end
#       end
#     end
#   end
# end

# class BitSet(N)

#   # ブロックの評価値で初期化
#   #
#   # ```
#   # BitSet(3).make(&.odd) # => 0b010
#   # ```
#   def self.make(&f : Int32 -> Bool) : Int64
#     v = 0_i64
#     N.times do |i|
#       next unless f.call(i)
#       v |= 1_i64 << i
#     end
#     return v
#   end

#   # 真偽値の配列で初期化
#   #
#   # ```
#   # BitSet(3).make([true, false, false]) # => 0b001
#   # ```
#   def self.make(a : Array(Bool)) : Int64
#     make { |i| a[i] }
#   end

#   # グラフの隣接リスト(0-indexed)から初期化
#   # ```
#   # BitSet(3).make([1,2]) # => 0b110
#   # ```
#   def self.make(a : Array(Int32)) : Int64
#     v = 0_i64
#     a.each do |i|
#       v |= 1_i64 << i
#     end
#     return v
#   end
# end
