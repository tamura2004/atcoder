def inc(x : Pointer(Int32))
  x.value = 20
end

x = 10
inc(pointerof(x))
#debug! x

require "spec"

it { 1.should eq 4 }
