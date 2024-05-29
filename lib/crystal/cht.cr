require "crystal/orderedset"

record Line, a : Int64, b : Int64 do
  include Comparable(Line)

  # 傾きの降順、y切片の昇順で比較
  #   /     \
  #  /   ->  \
  # /         \
  def <=>(other : Line) : Int32
    { -a, b } <=> { -other.a, other.b }
  end

  def cross(other : Line) : Int64
    (other.b - b) // (a - other.a)
  end

  def [](x : Int64)
    a * x + b
  end
end

# 動的 Convex Hull Trick
#  - 直線の追加: O(log N)
#  - 最小値クエリ: O(log N)
class CHT
  getter lines : Orderedset(Line)
  delegate to_a, size, to: lines

  def initialize
    @lines = Orderedset(Line).new
  end

  def add(line : Line)
    return if lines.includes?(line)

    # 傾きが同じ直線が既に存在する場合
    # y切片が小さい方を残す
    if left = lines.lower(line, eq: false)
      if line.a == left.a
        return unless line.b < left.b
        lines.delete(left)
        lines << line
      end
    else
      lines << line
    end

    # 傾きが同じ直線が既に存在する場合
    # y切片が小さい方を残す
    if right = lines.upper(line, eq: false)
      if line.a == right.a
        return unless line.b < right.b
        lines.delete(right)
        lines << line
      end
    else
      lines << line
    end

    # 両側に直線が存在する場合
    # 交点より小さい場合は追加する
    if left = lines.lower(line, eq: false)
      if right = lines.upper(line, eq: false)
        return unless left.cross(line) < line.cross(right)
        lines << line
      end
    end

    # 小さい方の直線が交点を上回る場合は削除する
    if left_right = lines.lower(line, eq: false)
      while left_left = lines.lower(left_right, eq: false)
        unless left_left.cross(left_right) < left_right.cross(line)
          lines.delete(left_right)
          left_right = left_left
        else
          break
        end
      end
    end

    # 大きい方の直線が交点を上回る場合は削除する
    if right_left = lines.upper(line, eq: false)
      while right_right = lines.upper(right_left, eq: false)
        unless line.cross(right_left) < right_left.cross(right_right)
          lines.delete(right_left)
          right_left = right_right
        else
          break
        end
      end
    end 
  end

  def <<(line : Line)
    add(line)
  end

  def min(x : Int64) : Int64
    return Int64::MAX if lines.size == 0
    return lines[0][x] if lines.size == 1
    return Math.min(lines[0][x], lines[1][x]) if lines.size == 2

    n = lines.size - 1
    i = (0...n).bsearch do |i|
      lines[i][x] < lines[i + 1][x]
    end || n
    lines[i][x]
  end
end
