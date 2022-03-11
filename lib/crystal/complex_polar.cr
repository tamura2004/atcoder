require "complex"

TAU = Math::PI * 2

struct Complex
  def self.polar(abs, phase) : self
    new(Math.cos(phase) * abs, Math.sin(phase) * abs)
  end

  def **(b)
    Complex.polar(abs * b, phase * b)
  end
end
