class Game:
  """
  aaa
  """
  DIRS = [(1, 0), (0, 1), (1, 1), (1, -1)]

  def __init__(self, height, width, win_length):
    self.height = height
    self.width = width
    self.win_length = win_length
    self.stones = {}
  
  def is_inside(self, y, x):
    return 0 <= y < self.height and 0 <= x < self.width

  def put_stone(self, y, x, color):
    if (y, x) in self.stones:
      return None
    self.stones[(y, x)] = color
    if self.is_win(y, x, color):
      return True
    else:
      return False

  def is_win(self, y, x, color):
    for (vy, vx) in self.DIRS:
      if self.win_length <= self.line_length_both(y, x, vy, vx, color):
        return True
    return False
  
  def line_length_side(self, y, x, vy, vx, color):
    ret = 0
    while self.is_inside(y, x) and ((y, x) in self.stones) and self.stones[(y, x)] == color:
      y += vy
      x += vx
      ret += 1
    return ret
  
  def line_length_both(self, y, x, vy, vx, color):
    return self.line_length_side(y, x, vy, vx, color) + self.line_length_side(y, x, -vy, -vx, color) - 1

game = Game(10, 20, 5)
assert(game.put_stone(5,5,1) == False)
assert(game.put_stone(5,5,1) == None)
assert(game.put_stone(6,4,1) == False)
assert(game.put_stone(7,3,1) == False)
assert(game.put_stone(4,6,1) == False)
assert(game.put_stone(3,7,1) == True)
