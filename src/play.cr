enum Head
  Up
  Left
  Down
  Right
end

class State
  class_property h : Int32 = 1
  class_property w : Int32 = 1
  getter y : Int32
  getter x : Int32
  getter d : Head
  getter v : Int32

  def initialize(@y, @x, @d, @v)
  end

  def make(y = y, x = x, d = d, v = v)
    State.new(y % @@h, x % @@w, d, v % 16)
  end

  def run(cmd) : Array(self) | self | Nil
    case cmd
    when '.'
      self
    when '<'
      make(d: Head::Left)
    when '>'
      make(d: Head::Right)
    when '^'
      make(d: Head::Up)
    when 'v'
      make(d: Head::Down)
    when '?'
      [
        make(d: Head::Left),
        make(d: Head::Right),
        make(d: Head::Up),
        make(d: Head::Down)
      ]
    when '_'
      if v.zero?
        make(d: Head::Right)
      else
        make(d: Head::Left)
      end
    when '|'
      if v.zero?
        make(d: Head::Down)
      else
        make(d: Head::Up)
      end
    when '+'
      make(v: v + 1)
    when '-'
      make(v: v - 1)
    when '0'..'9'
      make(v: cmd.to_i)
    when '@'
      nil
    else
      raise("bad cmd: #{cmd}")
    end
  end

  def go : self
    case d
    when Head::Up
      make(y: y - 1)
    when Head::Left
      make(x: x - 1)
    when Head::Down
      make(y: y + 1)
    when Head::Right
      make(x: x + 1)
    else
      raise("bad head")
    end
  end

  def_equals_and_hash y, x, d, v
end

h,w = gets.to_s.split.map(&.to_i)
State.h = h
State.w = w

cmds = Array.new(h){ gets.to_s }

seen = Hash(State,Bool).new do |h,k|
  h[k] = false
end

init = State.new(0, 0, Head::Right, 0)
q = Deque.new([init])
seen[init] = true

while q.size > 0
  v = q.shift
  case nv = v.run(cmds[v.y][v.x])
  when State
    nv = nv.go
    next if seen[nv]
    seen[nv] = true
    q << nv
  when Array(State)
    nv.each do |nv|
      nv = nv.go
      next if seen[nv]
      seen[nv] = true
      q << nv
    end
  when Nil
    puts "YES"
    exit
  else
    raise("bad type: #{nv.class}")
  end
end
puts "NO"
