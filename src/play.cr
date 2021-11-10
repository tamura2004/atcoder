class Hoge(T)
  # class_getter a : Array(T) = fuga

  def self.fuga
    Array.new(10) do |i|
      T.new(i)
    end
  end
end

pp Hoge(Int64).fuga