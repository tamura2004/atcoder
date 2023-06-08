class Sieve
  # MAX = 300_000_i64
  MAX = 30_i64
  getter is_prime : Array(Bool)
  getter min_factor : Array(Int64)
  getter moebius : Array(Int64)

  def initialize
    @is_prime = Array.new(MAX + 1, true)
    @min_factor = Array.new(MAX + 1, 0_i64)
    @moebius = Array.new(MAX + 1, 1_i64)

    is_prime[0] = false
    is_prime[1] = false
    min_factor[0] = 0_i64
    min_factor[1] = 1_i64
    moebius[0] = 0_i64
    moebius[1] = 1_i64

    (2i64..MAX).each do |i|
      next unless is_prime[i]
      min_factor[i] = i
      moebius[i] = -1_i64

      (i*2).step(by: i, to: MAX) do |j|
        is_prime[j] = false
        min_factor[j] = i if min_factor[j] == 0
        if (j // i).divisible_by?(i)
          moebius[j] = 0_i64
        else
          moebius[j] *= -1
        end
      end
    end
  end
end

sv = Sieve.new
pp sv.is_prime.zip(0..)
pp sv.min_factor.zip(0..)
pp sv.moebius.zip(0..)