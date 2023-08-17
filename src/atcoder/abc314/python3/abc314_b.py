from dataclasses import dataclass

@dataclass
class Player:
  id: int
  num: int
  bet: [int]

n = int(input())
players = [
  Player(i + 1, int(input()), [int(s) for s in input().split()])
  for i in range(n)
]
x = int(input())

winner = [player for player in players if x in player.bet]
if len(winner) == 0:
  print(0)
else:
  mini = min([player.num for player in winner])
  ans = [player.id for player in winner if player.num == mini]
  print(len(ans))
  print(" ".join(map(str, ans)))