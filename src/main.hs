import Control.Monad
import Control.Monad.ST
import Data.STRef

sum' :: [Int] -> Int
sum' xs = runST $ do
  ref <- newSTRef 0
  forM_ xs $ \i -> do
    modifySTRef ref (+ i)
  readSTRef ref

main :: IO()
main = print $ sum' [1..100]