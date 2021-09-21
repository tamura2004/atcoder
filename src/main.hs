main :: IO ()
main = do
  n <- readLn
  print $ n `mod` 21
