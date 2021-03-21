# 問題共通テンプレート
abstract class Problem
  macro make_array(i, v)
    Array.new({{i}}){ {{v}} }
  end

  macro make_array(i, j, v)
    Array.new({{i}}){ Array.new({{j}}){ {{v}} } }
  end

  macro make_array(i, j, k, v)
    Array.new({{i}}){ Array.new({{j}}){ Array.new({{k}}){ {{v}} } } }
  end

  macro make_array(i, j, k, l, v)
    Array.new({{i}}){ Array.new({{j}}){ Array.new({{k}}){ Array.new({{l}}){ {{v}} } } } }
  end

  macro chmax(target, other)
    {{target}} = ({{other}}) if ({{target}}) < ({{other}})
  end

  macro chmin(target, other)
    {{target}} = ({{other}}) if ({{target}}) > ({{other}})
  end

  def self.read
    read(STDIN)
  end

  def self.read(input : String)
    read(IO::Memory.new(input))
  end

  private def div_ceil(a, b)
    (a + b - 1) // b
  end
end
