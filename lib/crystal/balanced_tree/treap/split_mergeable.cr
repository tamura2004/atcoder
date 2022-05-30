module BalancedTree
  module Treap
    module SplitMergeable(T)
      abstract def split(k : T) : Tuple(self, self)
      abstract def merge(b : self) : self

      def +(b : self) : self
        merge(b)
      end

      def insert(k : T) : self
        fst, snd = split(k)
        node = self.class.new(k)
        fst.merge(node.merge(snd))
      end

      def <<(k : T) : self
        pp! k
        insert(k).tap{|t| pp! t}
      end
    end
  end
end
