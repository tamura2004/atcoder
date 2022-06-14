struct Range(B, E)
  # 左区間が常に真の時、区間の上限を求める
  # 通常の`#bsearch`の逆
  #
  # ```
  # (10..20).reverse_bsearch(&.< 10).should eq nil
  # (10..20).reverse_bsearch(&.< 15).should eq 14
  # (10..20).reverse_bsearch(&.< 100).should eq 20
  # ```
  def reverse_bsearch(&block : B | E -> Bool)
    from = self.begin
    to = self.end

    bsearch do |x|
      block.call(from + to - x)
    end.try { |x| from + to - x }
  end
end