require "crystal/avl_tree"

alias Orderedset = AVLTree

module Indexable(T)
  def to_ordered_set
    to_avl
  end
end
