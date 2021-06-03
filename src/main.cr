class PersistentArray(T)
  getter v : T
  getter ch : Array(self)?

  def initialize(@v)
    @ch = nil
  end

  def set(i, val)
  end

  def get(i)
  end
end

arr = PersistentArray(Int32).new(0)

pp arr