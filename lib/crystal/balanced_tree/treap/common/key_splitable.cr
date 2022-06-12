module BalancedTree
  module Treap
    module KeySplitable
      # `key`が`k`未満と、`k`以上で分割
      def split(k)
        if key < k
          @right, snd = right.try &.split(k) || {nil, nil}
          {update, snd}
        else
          fst, @left = left.try &.split(k) || {nil, nil}
          {fst, update}
        end
      end
    end
  end
end
