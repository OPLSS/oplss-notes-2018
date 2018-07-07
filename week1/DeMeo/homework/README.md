## Exercises from Week 1 of OPLSS 2018

### Jan Hoffmann

1. **Programming in PCF.** Implement the addition and multiplication functions for nats. Use the evaluation dynamics to symbolically describe the cost of the evaluation of `mult (n) (m)`
2. **Cost semantics and PPCF.** Implement a parallel version of `add` and `mult` in PPCF, using a maximal amount of parallelism. Symbolically describe the work and depth of the evaluation of `mult (n) (m)`
3. **Equivalence of the different dynamics.**
   a. Prove any part of the theorem from lecture that relates the parallel and sequential structural dynamics.
   b. Prove any part of the theorem from lecture that relates the cost dynamics (work and depth) and the parallel and sequential structural dynamics.
4. **Encoding of list in System F.** Encode the data type for lists of type tau in System F. Define the functions `head`, `tail`, and `cons`.

### Paul Downen

1. **System F numbers.** Using the encoding of Nat, zero, and successor in terms of functions and foralls, write down the system F representation of 1 (successor of zero), 2 (successor of successor of zero), 3 (successor of successor of successor of zero) and simplify them as much as possible to a normal form (apply the reduction rules, including underneath lambdas). What’s the pattern? What’s the system F representation of some natural number n?
2. **System F iteration.** Write a definition of the addition, multiplication, and predecessor functions on the system F encoding of natural numbers. You can use the definitions I gave based on the recursor on Thursday to get started. Predecessor is the tricky one.
3. **Abstract type independence.** Prove the following lemmas about the dynamic
   semantics of system F (in call-by-value and call-by-name).

   **Lemma.** For all expressions `e`, `e'` and types `tau`, `tau'`, `e[tau/a] |-> e'[tau/a]` if and only if `e[tau'/a] |-> e'[tau'/a]`.

   **Corollary.** For all expressions `e`, `e'` and types tau, `e[tau/a] |-> e'[tau/a]` if and only if `e |-> e'`.

   Why does this corollary imply, from the fact that running closed expressions (with no free variables and no free type variables), that it's okay (i.e., type safe) to run an expression even if it has free type variables?
