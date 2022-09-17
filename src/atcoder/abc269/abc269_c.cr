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
        getter i : {{t.id}}{{n}}

        def initialize(@v)
          @i = {{t.id}}{{n}}.zero
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

      def inv(n = {{n}})
        self ^ ((({{t.id}}{{n}}.zero + 1) << n) - 1)
      end

    end
  {% end %}
{% end %}

module Enumerable(T)
  def or
    reduce(T.zero) do |acc,v|
      acc | v
    end
  end
end

n = gets.to_s.to_i64
ans = n.subsets.to_a
ans.reverse_each do |v|
  puts v
end
