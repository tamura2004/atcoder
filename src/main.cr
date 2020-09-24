class Prime
  extend Iterator(Int32)

  @@ch = Channel(Int32).new
  @@once = true
  @@is_prime = [0,0,1,1,0,1,0,1,0,0,0,1]

  def self.next
    if @@once
      @@once = false
      spawn do
        10.times do |i|
          next if @@is_prime[i] == 0
          @@ch.send(i)
        end
        @@ch.close
      end
    end

    begin
      @@ch.receive
    rescue Channel::ClosedError
      stop
    end
  end
end

pp! Prime.each.first(10).to_a
