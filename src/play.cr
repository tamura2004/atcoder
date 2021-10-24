struct Arr
  getter a : Array(Int32)
  delegate "[]=", to: a

  def initialize
    @a = [1,2,3,4]
  end
end

a = Arr.new
b = [4,3,2,1]

hoge(a)
hoge(b)
pp! a
pp! b

def hoge(a)
  a[1] = 10
end
