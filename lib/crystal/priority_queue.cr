class PriorityQueue(T) < Array(T)
  def push(v)
    super(v)
    fixup(size - 1)
  end

  def pop
    ret = self[0]
    last = super
    if size > 0
      self[0] = last
      fixdown(0)
    end
    ret
  end

  def fixup(index : Int32)
    while index > 0
      parent = (index - 1) // 2
      break if self[parent] >= self[index]
      swap index, parent
      index = parent
    end
  end

  def fixdown(index : Int32)
    while true
      left = index * 2 + 1
      break if left >= size
      right = index * 2 + 2
      child = right >= size || self[left] > self[right] ? left : right
      if self[child] > self[index]
        swap child, index
        index = child
      else
        break
      end
    end
  end
end