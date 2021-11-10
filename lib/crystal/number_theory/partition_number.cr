module NumberTheory
  alias Fn = Proc(Array(Int64),Nil)
  alias PN = PartitionNumber

  class PartitionNumber
    def self.pf(n, k, a, &block : Fn)
      case
      when n == 0 then yield a
      when n == 1 then yield a
      when k == 1 then yield a
      else
        if k <= n
          a << k
          pf(n - k, k, a, &block)
          a.pop
        end

        pf(n, k - 1, a, &block)
      end
    end

    def self.each(n, &block : Fn)
      n = n.to_i64
      pf(n, n, [] of Int64, &block)
    end

  end
end
