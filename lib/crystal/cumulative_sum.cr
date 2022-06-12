# 累積和
#
# ```
# a = [1,2,3,2]
# cs = CumulativeSum(Int32).new(a)
# cs.n.should eq 4
# cs.a.should eq [1,2,2,3]
# cs.cs.should eq [0,1,3,5,8]
# ```
class CumulativeSum(T)
  getter a : Array(T)
  getter cs : Array(T)
  getter n : Int32

  def initialize(@a)
    a.sort!
    @n = a.size
    @cs = [T.zero]
    a.each { |ai| cs << ai + cs.last }
  end

  # `x`以上の要素の数
  #
  # ```
  # a = [1,2,3,2]
  # cs = CumulativeSum(Int32).new(a)
  # cs.count_upper(0).should eq 4
  # cs.count_upper(1).should eq 4
  # cs.count_upper(2).should eq 3
  # cs.count_upper(3).should eq 1
  # cs.count_upper(4).should eq 0
  # ```
  def count_upper(x : T)
    n - (a.bsearch_index(&.>= x) || n)
  end

  # `x`以下の要素の数
  #
  # ```
  # a = [1,2,3,2]
  # cs = CumulativeSum(Int32).new(a)
  # cs.count_lower(0).should eq 0
  # cs.count_lower(1).should eq 1
  # cs.count_lower(2).should eq 3
  # cs.count_lower(3).should eq 4
  # cs.count_lower(4).should eq 4
  # ```
  def count_lower(x : T)
    a.bsearch_index(&.> x) || n
  end

  # `x`以上の要素の合計
  #
  # ```
  # a = [1,2,3,2]
  # cs = CumulativeSum(Int32).new(a)
  # cs.sum_upper(0).should eq 8
  # cs.sum_upper(1).should eq 8
  # cs.sum_upper(2).should eq 7
  # cs.sum_upper(3).should eq 3
  # cs.sum_upper(4).should eq 0
  # ```
  def sum_upper(x : T)
    i = a.bsearch_index(&.>= x) || n
    cs[-1] - cs[i]
  end


  # `x`以下の要素の合計
  #
  # ```
  # a = [1,2,3,2]
  # cs = CumulativeSum(Int32).new(a)
  # cs.sum_lower(0).should eq 0
  # cs.sum_lower(1).should eq 1
  # cs.sum_lower(2).should eq 5
  # cs.sum_lower(3).should eq 8
  # cs.sum_lower(4).should eq 8
  # ```
  def sum_lower(x : T)
    i = a.bsearch_index(&.> x) || n
    cs[i]
  end
end

alias CS = CumulativeSum