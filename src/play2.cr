require "static_array"

a = StaticArray[1, 2]
b = StaticArray[1, 2]
c = StaticArray[StaticArray[1, 2],StaticArray[1, 2]]

pp c[0][1]
