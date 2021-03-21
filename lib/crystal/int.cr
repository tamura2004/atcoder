struct Int
  def f
    1.upto(self).product(&.itself)
  end
end