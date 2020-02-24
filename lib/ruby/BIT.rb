# Binary Indexed Tree
class BIT
    def initialize(n)
      @n = n
      @bit = Array.new(n+1,0) # 1 origin
    end
  
    # 1~i番目の要素の合計を求める
    def sum(i)
      ans = 0
      while i > 0
        ans += @bit[i]
        i -= i & -i
      end
      return ans
    end
  
    # i+1~n番目の合計を求める
    def greater(i)
      sum(@n) - sum(i)
    end
  
    # i番目の要素にxを加える
    def add(i,x)
      while i <= @n
        @bit[i] += x
        i += i & -i
      end
    end
  
    # 数列Aの転倒数を求める（副作用：内部状態の変更）
    def inversion!(a)
      ans = 0
      a.each do |x|
        add(x,1)
        ans += greater(x)
      end
      return ans
    end
  
  end
  
  # 入力、初期化
  n,k = gets.split.map &:to_i
  a = gets.split.map &:to_i
  bit = BIT.new(2000) # 要素数ではなく、値の最大値で初期化
  MOD = 10**9+7
  
  # s := An内での転倒数
  s = bit.inversion!(a)
  
  # t := ひとつ前のAnとの転倒数
  t = a.inject(0){|acc,x| acc += bit.greater(x) }
  
  # f(k) := k回繰り返した時の転倒数
  # f(1) = s 
  # f(k+1) = f(k) + k * t + s
  # => f(k) = ks + (k-1)kt/2
  
  ans = k * s + (k-1) * k * t / 2
  puts ans % MOD
  