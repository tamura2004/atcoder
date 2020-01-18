d,p = gets.split.map &:to_i
DIR_NAMES = %w(N NNE NE ENE E ESE SE SSE S SSW SW WSW W WNW NW NNW)
UNIT = 36000 / 32

def deg2dir(d)
    DIR_NAMES[(d+UNIT)%36000/2/UNIT]
end

puts deg2dir(12375)