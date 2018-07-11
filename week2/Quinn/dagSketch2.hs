type Node = Int
type Edge = (Node, Node)
type Graph = [Edge] 

data Matrix = Matrix [[Node]]
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
--mptMtrx = \ns -> take (length ns) (repeat ([a | a <- ns] ++ "\n"))
{-mtrxPrint :: [[Node]] -> IO ()
mtrxPrint [] = putStrLn ""
mtrxPrint (l:ls) = do
  putStrLn (map show l)
  mtrxPrint ls
-}
incidenceMatrix :: Graph -> [[Node]]
incidenceMatrix [] = [[]]
incidenceMatrix es = [[1]]

prMtrx :: Graph -> IO () -- just shows us the background empty matrix rn. 
prMtrx = putStr . unlines . map show . mptMtrx . getNodes
