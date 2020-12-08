struct Nil
  def ch
    {nil, nil}
  end
end

root = nil
pp! root.ch[0].ch[1]
