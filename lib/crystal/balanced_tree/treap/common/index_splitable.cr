module BalancedTree
  module Treap
    module IndexSplitable
      # `i`番目未満と以上で分割
      def split_at(i : Int)
        ord = left_size
        if ord < i
          @right, snd = right.try &.split_at(i - ord - 1) || {nil, nil}
          {update, snd}
        else
          fst, @left = left.try &.split_at(i) || {nil, nil}
          {fst, update}
        end
      end
    end
  end
end
