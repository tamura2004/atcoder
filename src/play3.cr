require "crystal/prime"

def each(acc, n, &block : Array(Int32) -> Nil)
  if acc.size == n
    block.call acc
  else
    if acc[-1] == 0
      each(acc + [0], n, &block)
      each(acc + [1], n, &block)
    else
      each(acc + [0], n, &block)
    end
  end
end

each([0], 8) do |arr|
  pp arr
end
