pv = [0, 1, 0, 2]

def to_path(pv, s, t, &block : Int32 -> _)
  return if s == t
  yield pv[t]
  to_path(pv, s, pv[t], &block)
end

to_path(pv, 0, 3) do |v|
  pp v
end
