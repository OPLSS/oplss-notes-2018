module Ap1 where

import Data.Array.Accelerate

dotp' :: Acc (Vector Float) -> Acc (Vector Float) -> Acc (Scalar Float)
dotp' xs ys = A.fold (+) 0 (A.zipWith (*) xs ys)

