import Data.List

type Node = Int
type Edge = (Node, Node)
type Graph = [Edge] 

data Matrix a = Matrix [[a]]
--showMatrix :: Matrix -> String
--showMatrix = unlines . map show {-
--instance Show (Matrix mss) => showMatrix mss -}
  
a :: Node
a = 0
b :: Node
b = 1
c :: Node
c = 2
d :: Node
d = 3
e :: Node
e = 4
f :: Node
f = 5
g :: Node
g = 6
    
ab :: Edge
ab = (a,b)
ac :: Edge
ac = (a,c)
bd :: Edge
bd = (b, d)
be :: Edge
be = (b, e)
df :: Edge
df = (d, f)
ef :: Edge
ef = (e, f)
cg :: Edge
cg = (c, g)
fg :: Edge
fg = (f, g)
-- a is source, g is sink.

rmDups :: Eq a => [a] -> [a]
rmDups []     = []
rmDups (x:xs) = x : (filter (/= x) (rmDups xs))

gr :: [Edge]
gr = [ab, ac, bd, be, df, ef, cg, fg]
-- indirection

occurencesNodes :: Graph -> [Node]
occurencesNodes [] = []
occurencesNodes (e:es) = (fst e) : (snd e) : (occurencesNodes es)
getNodes :: Graph -> [Node]
getNodes = rmDups . occurencesNodes

tails :: Graph -> [Node]
tails es = map fst es
heads :: Graph -> [Node]
heads es = map snd es

addEdge :: Edge -> Graph -> Graph
addEdge e es = e : es

-- incidence matrix
mptMtrx :: [Node] -> [[Node]]
mptMtrx ns = take n (repeat [0 | _<-ns]) where n = length ns
{-
isTail :: Node -> Edge -> Bool
isTail n = \e -> n == fst e
tailsN :: Node -> Graph -> [Node]
tailsN n g = filter (isTail n) gr
-}
incidenceMatrix :: Graph -> [[Node]]
incidenceMatrix [] = [[]]
incidenceMatrix es = [[1]]

prMtrx :: Graph -> IO () -- just shows us the background empty matrix rn. 
prMtrx = putStr . unlines . map show . mptMtrx . getNodes


isSquare :: [[a]] -> Bool
isSquare (l:ls) = and ((length (l:ls) == length l) : [length l == length k | k <- ls])

tail' :: [a] -> [a]
tail' [] = []
tail' (x:xs) = xs

{-
*Main> isIrreflexive [[1,2,3],[4,5,6],[7,8,9]]
False
*Main> isIrreflexive [[0,2,3],[4,0,6],[7,8,0]]
True
-}

isIrreflexive :: (Num a, Eq a) => [[a]] -> Bool
-- all zeros in diagonal
isIrreflexive [] = True
isIrreflexive [[]] = True
isIrreflexive [[x]] = if x == 0 then True else False
isIrreflexive ((x:xs):yss) = if x /= 0 then False else isIrreflexive l
  where l = (map tail yss)
-- this is quadratic.

-- all entries below diagonal is zero.
allZeroUpToNth :: (Num a, Eq a) => a -> ([a] -> Bool)
allZeroUpToNth _ [] = True
allZeroUpToNth 0 _  = True
allZeroUpToNth n (x:xs) = if x==0 then allZeroUpToNth (n-1) xs else False
isLowerTriangle :: (Num a, Eq a) => [[Int]] -> Bool
isLowerTriangle lss = and (map and [map (allZeroUpToNth k) lss | k <- [0..n]]) where n = length lss

mtrxTransposed :: [[a]] -> [[a]]
mtrxTransposed m = transpose m

isSymmetric :: Eq a => [[a]] -> Bool
isSymmetric m = m == (transpose m)
--symmetric matrices are undirected graphs.

isDAG :: (Num a, Eq a) => [[a]] -> Bool
isDAG m = (not . isSymmetric) m && isIrreflexive m
