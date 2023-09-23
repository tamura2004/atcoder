struct Int
  def iota
    Range.new(typeof(self).multiplicative_identity, self)
  end
end

n, r = gets.to_s.split.map(&.to_i64)
p n.iota.product // r.iota.product // (n - r).iota.product
