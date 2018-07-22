{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE GADTs #-}
-- deep embedding example
module Deep3 where

data Expr a where
  Add :: Expr Float -> Expr Float -> Expr Float
  Neg :: Expr Float -> Expr Float
  Less :: Expr Float -> Expr Float -> Expr Bool

  Const :: a -> Expr a
  If :: Expr Bool -> Expr a -> Expr a -> Expr a


simplify :: Expr a -> Expr a
simplify (Const n) = Const n
simplify (Neg (Neg e)) = e
-- ...

-- etc. 
