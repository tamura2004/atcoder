class Doubling(T)
  getter n : T
  getter depth : T
  getter f : T? -> T?
  getter link : Array(Array(T?))
  getter csum : Array(Array(T?))

  def initialize(@n, @depth = T.new(60), &block : T -> T?)
    @link = Array.new(depth + 1) { Array(T?).new(n, nil) }
    @csum = Array.new(depth + 1) { Array(T?).new(n, nil) }
    @f = ->(i : T?) {
      i && block.call(i)
    }
    n.times do |i|
      link[0][i] = f.call(i)
      csum[0][i] = T.new(i)
    end
    build
  end

  def build
    depth.times do |k|
      n.times do |v|
        nv = link[k][v]
        next if nv.nil?
        link[k + 1][v] = link[k][nv]
        csum[k + 1][v] = add(csum[k][v], csum[k][nv])
      end
    end
    return self
  end

  def solve(from : T, step : Int) : T?
    v = from
    depth.times do |k|
      break if v.nil?
      v = link[k][v] if step.bit(k) == 1
    end
    return v
  end

  def solve2(from : T, step : Int) : T?
    v = from
    step.times do
      break if v.nil?
      v = link[0][v]
    end
    return v
  end

  def sum(from : T, step : Int) : T?
    ans = T.zero
    v = from
    depth.times do |k|
      break if v.nil?
      if (step+1).bit(k) == 1
        ans = add(ans, csum[k][v])
        v = link[k][v]
      end
    end
    return ans
  end

  def sum2(from : T, step : Int) : T?
    ans = T.new(from)
    v = from
    step.times do
      break if v.nil?
      v = link[0][v]
      ans = add(ans, v)
    end
    return ans
  end

  def add(a : T?, b : T?) : T?
    return T::MAX if a == T::MAX
    return T::MAX if b == T::MAX
    begin
      a && b ? a + b : a ? a : b ? b : nil
    rescue exception
      T::MAX
    end
  end
end
