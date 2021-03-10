class Hoge
  def initialize(&@f : Proc(Int32) = Proc(Int32).new { |x| puts x })
  end
end
