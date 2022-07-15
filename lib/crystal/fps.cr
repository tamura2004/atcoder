require "string_scanner"

# 形式的べき級数のライブラリ
module FPS
  # 単項式
  struct Term
    getter index : Int32 # 指数
    getter coeff : Int32 # 係数

    def initialize(sign, @coeff, @index)
      @coeff *= sign
    end
  end

  # 多項式
  struct Expr
    getter terms : Array(Term)
    delegate "<<", to: terms

    def initialize
      @terms = [] of Term
    end

    def to_a
      max_index = terms.map(&.index).max
      Array.new(max_index+1, 0).tap do |ans|
        terms.each do |term|
          ans[term.index] += term.coeff
        end
      end
   end
  end

  # 多項式のパーサ
  #
  # <expr> ::= <term>[<term>]*
  # <term> ::= <sign><coeff><index>
  # <sign> ::= [('+'|'-')]
  # <coeff> ::= [<number>'*']
  # <index> ::= ['x']['^'][<number>]
  struct Parser
    getter s : StringScanner
    delegate scan, eos?, to: s
    getter expr : Expr

    def initialize(s)
      @s = StringScanner.new(s.gsub(" ", ""))
      @expr = Expr.new
    end

    # <expr> ::= <term>[<term>]*
    def parse
      while !eos?
        expr << term
      end
      expr
    end

    # <term> ::= <sign><coeff><index>
    def term
      Term.new sign, coeff, index
    end

    # <sign> ::= [('+'|'-')]
    def sign
      case
      when scan(/\+/) then 1
      when scan(/\-/) then -1
      else                 1
      end
    end

    # <coeff> ::= [<number>'*']
    def coeff
      number.tap { scan(/\*/) } || 1
    end

    # <index> ::= ['x']['^'][<number>]
    def index
      case
      when scan(/x\^/) then number.not_nil!
      when scan(/x/)   then 1
      else                  0
      end
    end

    # <number> ::= [0-9]+
    def number
      scan(/\d+/).try &.to_i
    end
  end
end
