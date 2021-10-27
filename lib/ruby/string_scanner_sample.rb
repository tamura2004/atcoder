require "strscan"
require "forwardable"

# 構文解析サンプル
#
# <expr> ::= <term>[('+'|'-')<term>]*
# <term> ::= <factor>[('*'|'/')<factor>]*
# <factor> ::= <number> | '(' <expr> ')'
# <number> ::= [0-9]+
#
class Parser
  extend Forwardable
  def_delegators "@s", "eos?", "scan"

  def initialize(s)
    @s = StringScanner.new(s)
  end

  # <expr> ::= <term>[('+'|'-')<term>]*
  def expr
    ast = term
    while !eos?
      case
      when scan(/\+/) then ast = ["+", ast, term]
      when scan(/\-/) then ast = ["-", ast, term]
      else break
      end
    end
    ast
  end

  # <term> ::= <factor>[('*'|'/')<factor>]*
  def term
    ast = factor
    while !eos?
      case
      when scan(/\*/) then ast = ["*", ast, factor]
      when scan(/\//) then ast = ["/", ast, factor]
      else break
      end
    end
    ast
  end

  # <factor> ::= <number> | '(' <expr> ')'
  def factor
    case
    when scan(/\(/) then expr.tap { scan(/\)/) }
    else number
    end
  end

  def number
    n = scan(/\d+/)
    [n, nil, nil]
  end
end

ast = Parser.new("1+2+3+4+5").expr

def bfs(ast)
  op, lo, hi = ast
  case op
  when /\d+/ then op.to_i
  when "+" then bfs(lo) + bfs(hi)
  when "-" then bfs(lo) - bfs(hi)
  when "*" then bfs(lo) * bfs(hi)
  when "/" then bfs(lo) / bfs(hi)
  end
end

# pp ast
pp bfs(ast)
