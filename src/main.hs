import Data.List (transpose)

data Ans = Yes | No deriving (Read, Show)

main :: IO ()
main = do
  n <- readLn
  (s, t) <- splitAt n . lines <$> getContents
  print $ solve s t

solve :: [String] -> [String] -> Ans
solve s t
  | (clip s !! 4) `elem` take 4 (drop 4 $ clip t) = Yes
  | otherwise = No

clip :: [String] -> [[String]]
clip = iterate $ transpose . reverse . dropWhile (all (== '.'))