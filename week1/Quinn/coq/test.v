(* Examples *) 

(* True Example *) 
Example true_ex : True. 
Proof.
        constructor.
Qed.

(* Conjunction Example *) 
Example conj_ex : True /\ True. 
Proof. 
       split
       - constructor.
       - constructor.
Qed. (* doesn't work w/o split *) 

(* Disjunction Example *) 
Example conj_ex : True \/ True.
Proof.
        split 
        - constructor.
        - constructor.
Qed.

(* Equality Transitivity *) 
Example nat_trans (x y z : nat) : x = y => y = z -> x = z.
Proof.
        (* intros x y z. *) 
        intro Hxy. intro Hyz.
        rewrite Hxy. rewrite Hyz.
        reflexivity.
Qed.

(* Constructors *) 
Module Constructor.

(* True *) 
Inductive True := 
  | I : True

Example true_ex2 : True.
Proof. 
  apply I. 
Qed.

(* False *) 
Example false_ex : False -> False.
Proof.
  intro F.
  inversion F.
Qed.

Example false_ex2 : False -> False \/ True

(* Disjunction *)
Inductive or P Q := 
  | 


(* Conjunction *) 
Inductive and P Q := 
 | conj : and P -> Q -> and P Q. 

Example conj_ex2 : True /\ False.
Proof.
        apply (conj). 

(* Disjunction *) 

Inductive or P Q := 
 | or_introl : P -> or P Q
 | or_intror : Q -> or P Q.

(* Existential Quantification *) 