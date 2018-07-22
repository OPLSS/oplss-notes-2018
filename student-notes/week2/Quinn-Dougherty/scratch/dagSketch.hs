import Data.Graph.Inductive.Graph

type Node = Char
type Edge a = (Node, Node, 


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

a' :: LNode Char
a' = (a', 'a')
b' :: LNode Char
b' = (b', 'b')
c' :: LNode Char
c' = (c', 'c')
d' :: LNode Char
d' = (d', 'd')
e' :: LNode Char
e' = (e', 'e')
f' :: LNode Char
f' = (f', 'f')
g':: LNode Char
g' = (g', 'g')

ab :: LEdge String
ab = (a,b, "ab")
ac :: LEdge String
ac = (a,c, "bd")
bd :: LEdge String
bd = (b, d, "bd")
be :: LEdge String
be = (b, e, "be")
df :: LEdge String
df = (d, f, "df")
ef :: LEdge String
ef = (e, f, "ef")
cg :: LEdge String
cg = (c, g, "cg")
fg :: LEdge String
fg = (f, g, "fg")

-- a is a source, g is a sink.

myNodes :: [LNode Char]
myNodes = [a', b', c', d', e', f', g']
myEdges :: [LEdge String]
myEdges = [ab, ac, bd, be, df, ef, cg, fg]

instance Graph myGraph where
 {- empty :: myGraph Char String

  isEmpty ::

  match
-}
  mkGraph :: myGraph Char String
  
--  labNodes ::
