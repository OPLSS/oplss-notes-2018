## OPLSS 2018 Week 2 Homework

### Exercise from Guy Blelloch

```ml
datatype treeSeq = Empty | Node of int * treeSeq * treeSeq 
fun split (p, Empty) = (Empty, Empty)
   | split (p, Node(v, L, R)) =
     if p < v then
       let val (L1 ,R1) = split(p ,L)
       in (L1,Node(v, R1, R)) end
     else
       let val (L1,R1) = split(p ,R)
       in (Node (v, L, L1), R1) end;
fun myfunc(A, B) =
  let
    val Node(m, AL, AR) = A
    val (BL ,BR) = split(B, m)
  in Node(m, myfunc(AL, BL), myfunc(AR, BR))
```

Assume the two input trees to `myfunc` are balanced and the integer values are 
"in-order" within each tree.

- What does `myfunc` do?
- What is its work and span?  

(You can assume the two trees have equal size and the split function splits 
the tree in half.)


## Exercise from Umut
implement! 
flatten A : (alpha Seq) Seq -> alpha Seq
expensive suggestion: "flatten A = reduce () append A"
which is, where r is the length of result and a is the length of outer input list
- wk(flatten A)=O(r*lg(a)) 
- sp(flatten A)=O(lg(a)) 

your goal: 
-- implement a version in linear work, with the same span. 
so make flatten' such that 
- wk(flatten' A) = O(a)
- wk(flatten' A) = O(lg(a))