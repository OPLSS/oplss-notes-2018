module Test where

import Data.Array.Accelerate              as A
--import Data.Array.Accelerate.LLVM.Native  as CPU
-- import Data.Array.Accelerate.LLVM.PTX     as GPU

dotp :: Acc (Vector Float) -> Acc (Vector Float) -> Acc (Scalar Float)
dotp xs ys = A.fold (+) 0 (A.zipWith (*) xs ys)

{-
ghci> let xs = fromList (Z:.10) [0..]   :: Vector Float
ghci> let ys = fromList (Z:.10) [1,3..] :: Vector Float
ghci> CPU.run $ dotp (use xs) (use ys)
Scalar Z [615.0]
-}

