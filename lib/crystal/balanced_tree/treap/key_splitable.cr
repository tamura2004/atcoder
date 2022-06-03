module BalancedTree
  module Treap
    module KeySplitable(K)
      # k未満と、k以上で分割
      def split(k : K) : {KeySplitable(K)?, KeySplitable(K)?}
        if key < k
          @right, snd = right.try &.split(k) || {nil.as(KeySplitable(K)?), nil.as(KeySplitable(K)?)}
          {update, snd}
        else
          fst, @left = left.try &.split(k) || {nil.as(KeySplitable(K)?), nil.as(KeySplitable(K)?)}
          {fst, update}
        end
      end
    end
  end
end
