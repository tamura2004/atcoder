require "benchmark/ips"
require "prime"

MOD = 1_000_000_007
MOD_LIST = (MOD - 2).to_s(2).split('').map(&:to_i).reverse

def modinv_a(a,m)
  b,u,v = m,1,0
  while b > 0
    t = a / b
    a -= t * b; a,b = b,a
    u -= t * v; u,v = v,u
  end
  u %= m
end

def modinv_b(num, modu, modu_list = [])
  result = num
  result_list = [num % modu]
  time_time = 1
  while result_list.length < modu_list.length do
    result = result**2 % modu
    time_time *= 2
    result_list << result
  end
  result = 1
  result_list.each_with_index do |e, i|
    result = result * e % modu if modu_list[i] != 0
  end
  result
end

LIST = Array.new(100){rand(MOD)}

Benchmark.ips do |x|
    x.report("a") {
        LIST.each do |n|
            modinv_a(n, MOD)
        end
    }
    x.report("b") {
        LIST.each do |n|
            modinv_b(n, MOD, MOD_LIST)
        end
    }
    x.compare!
end
