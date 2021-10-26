require "string_scanner"

# 構文解析サンプル
struct StringScannerSample
  getter s : StringScanner
  delegate scan, eos?, to: s

  def initialize(s)
    @s = StringScanner.new(s)
  end

  def number
    ans = 0_i64
    if num = scan(/\d+/)
      ans += num.to_i64
    end
    ans
  end

  def factor
    if scan(/\(/)
      ans = expression
      scan(/\)/)
      ans
    else
      number
    end
  end

  def term
    ans = number
    if scan(/\*/)
      ans *= factor
    elsif scan(/\//)
      ans /= factor
    end
    ans
  end

  def expression
    ans = term
    while !eos?
      if scan(/\+/)
        ans += term
      elsif scan(/\-/)
        ans -= term
      else
        break
      end
    end
    ans
  end
end
