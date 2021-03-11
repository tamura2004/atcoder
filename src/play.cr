class Father
  getter memo : Array(Int32?)

  def initialize
    @memo = Array.new(10, nil.as(Int32?))
  end

  def say(n)
    pp "father"
    memo[n] ||= say(n)
  end
end

class Som < Father
  def say(n)
    pp "me"
    super(n) + 10
  end
end

Som.new.say(3)