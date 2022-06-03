module BalancedTree
  module Treap
    module Mergeable
      # 木の結合
      def merge(b : self?)
        return self if b.nil?

        if pri > b.pri
          @right = right.try &.merge(b) || b
          update
        else
          b.left = merge(b.left)
          b.update
        end
      end
    end
  end
end
