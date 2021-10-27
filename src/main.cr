require "string_scanner"

# 構文解析サンプル
#
# <expr> ::= <term>[('+'|'-')<term>]*
# <term> ::= <factor>[('*'|'/')<factor>]*
# <factor> ::= <number> | '(' <expr> ')'
# <number> ::= [0-9]+
#
struct StringScannerSample
  getter s : StringScanner
  delegate scan, eos?, to: s

  def initialize(s)
    @s = StringScanner.new(s)
  end

  # <expr> ::= <term>[('+'|'-')<term>]*
  def expr
    ans = term
    while !eos?
      case
      when scan(/\+/) then ans += term
      when scan(/\-/) then ans -= term
      else                 break
      end
    end
    ans
  end

  # <term> ::= <factor>[('*'|'/')<factor>]*
  def term
    ans = factor
    while !eos?
      case
      when scan(/\*/) then ans *= factor
      when scan(/\//) then ans /= factor
      else                 break
      end
    end
    ans
  end

  # <factor> ::= <number> | '(' <expr> ')'
  def factor
    case
    when scan(/\(/) then begin expr ensure scan(/\)/) end
    else number
    end
  end

  def number
    scan(/\d+/).try &.to_i64 || 0_i64
  end
end

while true
  print "> "
  s = gets.to_s
  puts StringScannerSample.new(s).expr
end
