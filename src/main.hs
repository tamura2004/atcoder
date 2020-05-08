import Data.Bits

type Mask = Int
type Pair = (Int, Mask)

base :: [Int]
base = [3, 5, 7]

mask :: [Mask]
mask = [1, 2, 4]

seed :: [Pair]
seed = zip base mask

conv :: Pair -> Pair -> Pair
conv (i, s) (j, t) = (i * 10 + j, s .|. t)

gen :: [Pair]
gen = seed ++ [conv pre post | pre <- gen, post <- seed]

ans :: [Int]
ans = [i | (i, s) <- gen, s == 7]

main :: IO ()
main = do
    n <- readLn
    print $ length $ takeWhile (<= n) ans
