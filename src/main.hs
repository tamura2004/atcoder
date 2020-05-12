solve :: Int -> Int -> Int
solve l x
  | r < l = r
  | otherwise = ll - r
  where
    ll = 2 * l
    r = x `mod` ll

main :: IO ()
main = do
    [l, x] <- map read . words <$> getLine
    print $ solve l x
