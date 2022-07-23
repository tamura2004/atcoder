enum S
  Zero
  One
  Normal
  Reverse
end

class Problem
  getter n : Int32
  getter c : Int32
  getter st : Array(S)

  def initialize(@n,@c)
    @st = Array.new(30) { S::Normal }
  end

  def update_and(x)
    30.times do |i|
      if x.bit(i) == 1
      else
        st[i] = S::Zero
      end
    end
  end

  def update_or(x)
    30.times do |i|
      if x.bit(i) == 1
        st[i] = S::One
      end
    end
  end

  def update_xor(x)
    30.times do |i|
      if x.bit(i) == 1
        case st[i]
        when .zero?
          st[i] = S::One
        when .one?
          st[i] = S::Zero
        when .normal?
          st[i] = S::Reverse
        when .reverse?
          st[i] = S::Normal
        end
      end
    end
  end
  
  def calc
    ans = 0
    30.times do |i|
      case st[i]
      when .zero?
      when .one?
        ans |= (1 << i)
      when .normal?
        ans |= (1 << i) if c.bit(i) == 1
      when .reverse?
        ans |= (1 << i) if c.bit(i) == 0
      end
    end
    ans
  end

  def solve
    n.times do
      t, a = gets.to_s.split.map(&.to_i)
      case t
      when 1
        update_and(a)
      when 2
        update_or(a)
      when 3
        update_xor(a)
      end
      @c = calc
      pp c
    end
  end
end

n, c = gets.to_s.split.map(&.to_i)
pr = Problem.new(n, c)
pr.solve
