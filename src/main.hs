main = do
  xs <- map read.words <$> getLine
  print $ solve xs

solve = succ.length.takeWhile (/=0)