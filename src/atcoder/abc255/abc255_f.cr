class Problem
  getter n : Int32
  getter pre : Array(Int32)
  getter ino : Array(Int32)
  getter idx : Array(Int32)
  getter ans : Array(Array(Int32))

  def initialize(@n, @pre, @ino)
    @ans = Array.new(n) { [0, 0] }
    @idx = Array.new(n, -1)
    ino.each_with_index do |v, i|
      idx[v.pred] = i
    end
  end

  def self.read
    n = gets.to_s.to_i
    pre = gets.to_s.split.map(&.to_i)
    ino = gets.to_s.split.map(&.to_i)
    new(n, pre, ino)
  end

  def solve
    quit -1 if pre[0] != 1
    cnt = valid(0, n, 0, n)
    if cnt
      puts ans.map(&.join(" ")).join("\n")
    else
      puts -1
    end
  end

  def valid(lop, hip, loi, hii)
    # pp! pre[lop...hip]
    # pp! ino[loi...hii]
    sizep = hip - lop
    sizei = hii - loi
    return false if sizep != sizei
    return true if sizep == 0

    # [root]
    # [root]
    if sizep == 1
      if pre[lop] == ino[loi]
        return true
      else
        return false
      end
    end

    # [root][right]...
    # [root]..[right].
    if pre[lop] == ino[loi]
      ans[pre[lop].pred] = [0, pre[lop.succ]]
      return valid(lop + 1, hip, loi + 1, hii)
    end

    # [root][left]....
    # ..[left]...[root]
    if pre[lop] == ino[hii - 1]
      ans[pre[lop].pred] = [pre[lop.succ], 0]
      return valid(lop + 1, hip, loi, hii - 1)
    end

    # [root][left]....[right]....
    # ..[left]..[root]..[right]..
    root = pre[lop]
    left = pre[lop.succ]
    i = idx[root.pred]
    right = pre[i - loi + lop + 1]
    ans[pre[lop].pred] = [left, right]
    return valid(lop + 1, i - loi + lop + 1, loi, i) && valid(i - loi + lop + 1, hip, i + 1, hii)
  end
end

Problem.read.solve
