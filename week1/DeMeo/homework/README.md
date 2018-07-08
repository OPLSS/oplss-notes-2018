## Exercises from Week 1 of OPLSS 2018

---

### Lecture 1 (Downen)

1. We defined a language with numbers, booleans, and variables, with operations plus, less, ite, and let.  Add more operations to this language (e.g., minus, multiplication, equality).
2. **Properties of Substitution.** Prove the following properties of
   substitution for the language of nats and bools defined in the first lecture. (*Hint:* structural induction)
     + (∀ e  e') ( BV(e') ∩ FV(e) = ∅ implies e'[e/x] is defined )
     + (∀ e  e') ( x ∉ FV(e') implies e'[e/x] = e' )
3. **Properties of α-equivalence.** Prove the following properties of α-equivalence for the language of nats and bools defined in the first lecture. (*Hint:* structural induction)
   + (∀ e e') ( ∃ e'' ) ( e =α e'' and e''[e'/x] is defined )
   + (∀ e e' e'') ( e =α e' implies e[e''/x] =α e'[e''/x] )

---

### Lecture 1 (Hoffmann)

Recall the following lemmas stated in Jan's first and second lectures:

**Lemma 1.** For every expression e, and every context Γ, there is at most one type τ such that Γ ⊢ e : τ.

**Lemma 2.** (Substitution) If Γ, x : τ ⊢ e' : τ' and Γ ⊢ e : τ, then
Γ ⊢ [e/x] e' : τ'.

**Lemma 3.** (Weakening) If Γ ⊢ e : τ and x ∉ Γ, then Γ, x : τ' ⊢ e : τ.

1. Lemma 1 is proved by rule induction for each of the rules.  In lecture the cases of Plus and var were handled.  Finish the proof.
2. Prove Lemma 2 by rule induction.
3. Prove Lemma 3 by rule induction.

---

### Lecture 2 (Hoffmann)

Recall the Progress/Preservation Theorem stated in Lecture 2.

**Theorem.**
+ (Progress) If ⋅ ⊢ e : τ, then either e val or ∃ e' . e ↦ e'.
+ (Preservation) If ⋅ ⊢ e : τ and e ↦ e', then ⋅ ⊢ e' : τ.

1. *Progress* is proved by rule induction. The Plus rule case was handled in lecture.  Do the other cases.
2. Prove *Preservation*.

---

### Lecture 2 (Downen)
1. Encode the natural numbers in the λ-calculus.

---

### Lectures 4, 5 (Hoffmann)

1. **Programming in PCF.** Implement the addition and multiplication functions for nats. Use the evaluation dynamics to symbolically describe the cost of the evaluation of `mult (n) (m)`
2. **Cost semantics and PPCF.** Implement a parallel version of `add` and `mult` in PPCF, using a maximal amount of parallelism. Symbolically describe the work and depth of the evaluation of `mult (n) (m)`
3. **Equivalence of the different dynamics.**
   a. Prove any part of the theorem from lecture that relates the parallel and sequential structural dynamics.
   b. Prove any part of the theorem from lecture that relates the cost dynamics (work and depth) and the parallel and sequential structural dynamics.
4. **Encoding of list in System F.** Encode the data type for lists of type tau in System F. Define the functions `head`, `tail`, and `cons`.

---

### Lectures 4, 5 (Downen)

1. **System F numbers.** Using the encoding of Nat, zero, and successor in terms of functions and foralls, write down the System F representation of 1 (successor of zero), 2 (successor of successor of zero), 3 (successor of successor of successor of zero) and simplify them as much as possible to a normal form (apply the reduction rules, including underneath lambdas). What's the pattern? What's the System F representation of some natural number n?
2. **System F iteration.** Write a definition of the addition, multiplication, and predecessor functions on the System F encoding of natural numbers. You can use the definitions I gave based on the recursor on Thursday to get started. Predecessor is the tricky one.
3. **Abstract type independence.** Prove the following lemmas about the dynamic semantics of System F (in call-by-value and call-by-name).

   **Lemma.** (∀ e e') (∀ τ τ') ( e[τ/α] ↦ e'[τ/α] if and only if  e[τ'/α] ↦ e'[τ'/α] ).

   **Corollary.** (∀ e e') (∀ τ) (e[τ/α] ↦ e'[τ/α] if and only if e ↦ e' ).

   Why does this corollary imply---from the fact that running closed expressions (with no free variables and no free type variables)---that it's okay (i.e., type safe) to run an expression even if it has free type variables?

---

### Lectures 6, 7, 8 (Downen)


#### Linear logic and lambda calculus

1. **Additive versus multiplicative** For each of the following pair of statements using linear conjunctions and disjunctions, determine which ones are provable and which ones are not provable. What is preventing you from proving one of the statements? Does using the “Mix” rule help in some cases?

   (τ -||- τ') means to give a proof derivation of BOTH τ ⊢ τ' and τ ⊣ τ'.

   + **a)** τ -||- τ & τ   versus    τ -||- τ ⊗ τ

   + **b)** τ, τ -||- τ & τ    versus    τ, τ -||- τ ⊗ τ

   + **c)** τ ⊕ τ -||- τ    versus    τ ⅋ τ -||- τ

   + **d)** τ ⊕ τ -||- τ, τ    versus   τ ⅋ τ -||- τ, τ

2. **Copy and delete** Not every value can be copied and deleted in the linear lambda calculus, but some can. These types of values are described by the following subset of types:

   P ::= 0 | 1 | !τ | P₁ ⊗ P₂ | P₁ ⊕ P₂

    Write the following copy and delete function for each such type P. (The function definition will be different for each type.)

   delete{P} : P ⊸ 1  
   copy{P} : P ⊸ P ⊗ P

   *Hint* since the the definition of delete{P} and copy{P} is different for each P, try defining them by induction on the definition of P above. The base cases are for 0, 1, and !tau, whereas the definitions of P₁ ⊗ P₂ and P₁ ⊕ P₂ will depend on the definitions of P₁ and P₂.
