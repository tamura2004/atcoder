class MergeSortTree(T)
  getter sorted : Array(Array(T))
  getter arr : Array(Array(T))
  getter cs : Array(Array(T))
  getter n : Int32

  def initialize(values : Array(T))
    @n = Math.pw2ceil(values.size)
    @sorted = Array.new(n*2) { [] of T }
    @arr = Array.new(n*2) { [] of T }
    @cs = Array.new(n*2) { [T.zero] }

    values.each_with_index do |v, i|
      @sorted[i+n] << v
      @arr[i+n] << v
      @cs[i+n] << v
    end

    (1...n).reverse_each do |i|
      left = i * 2
      right = i * 2 + 1
      l_ptr = r_ptr = 0
      l_size = sorted[left].size
      r_size = sorted[right].size

      while l_ptr < l_size || r_ptr < r_size
        l_value = l_ptr == l_size ? T::MAX : sorted[left][l_ptr]
        r_value = r_ptr == r_size ? T::MAX : sorted[right][r_ptr]

        if l_value < r_value
          sorted[i] << sorted[left][l_ptr]
          l_ptr += 1
        else
          sorted[i] << sorted[right][r_ptr]
          r_ptr += 1
        end
      end

      arr[i] = arr[left] + arr[right]
      sorted[i].each do |v|
        cs[i] << cs[i][-1] + v
      end
    end
  end

  # 区間[lo, hi)においてAi <= kを満たす要素の合計を求める
  def range_sum_under(lo , hi , k)
    lo += n
    hi += n

    sum = T.zero

    while lo < hi
      if lo.odd?
        idx = sorted[lo].bsearch_index(&.> k) || sorted[lo].size
        sum += cs[lo][idx]
        lo += 1
      end

      if hi.odd?
        hi -= 1
        idx = sorted[hi].bsearch_index(&.> k) || sorted[hi].size
        sum += cs[hi][idx]
      end

      lo >>= 1
      hi >>= 1
    end

    sum
  end
end
