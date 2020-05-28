# ruby2.3 互換用
module Enumerable
  def tally
    Hash.new(0).tap { |h| each { |a| h[a] += 1 } }
  end
end
