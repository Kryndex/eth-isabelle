(*Generated by Lem from set.lem.*)
open HolKernel Parse boolLib bossLib;
open lem_boolTheory lem_basic_classesTheory lem_maybeTheory lem_functionTheory lem_numTheory lem_listTheory lem_set_helpersTheory lemTheory;

val _ = numLib.prefer_num();



val _ = new_theory "lem_set"

(******************************************************************************)
(* A library for sets                                                         *)
(*                                                                            *)
(* It mainly follows the Haskell Set-library                                  *)
(******************************************************************************)

(* Sets in Lem are a bit tricky. On the one hand, we want efficiently executable sets.
   OCaml and Haskell both represent sets by some kind of balancing trees. This means
   that sets are finite and an order on the element type is required. 
   Such sets are constructed by simple, executable operations like inserting or
   deleting elements, union, intersection, filtering etc.

   On the other hand, we want to use sets for specifications. This leads often
   infinite sets, which are specificied in complicated, perhaps even undecidable
   ways.

   The set library in this file, chooses the first approach. It describes 
   *finite* sets with an underlying order. Infinite sets should in the medium
   run be represented by a separate type. Since this would require some significant
   changes to Lem, for the moment also infinite sets are represented using this
   class. However, a run-time exception might occour when using these sets. 
   This problem needs adressing in the future. *)
   

(* ========================================================================== *)
(* Header                                                                     *)
(* ========================================================================== *)

(*open import Bool Basic_classes Maybe Function Num List Set_helpers*)

(* DPM: sets currently implemented as lists due to mismatch between Coq type
 * class hierarchy and the hierarchy implemented in Lem.
 *)
(*open import {coq} `Coq.Lists.List`*)
(*open import {hol} `lemTheory`*)
(*open import {isabelle} `$LIB_DIR/Lem`*)

(* ----------------------- *)
(* Equality check          *)
(* ----------------------- *)

(*val setEqualBy : forall 'a. ('a -> 'a -> ordering) -> set 'a -> set 'a -> bool*)

(*val setEqual : forall 'a. SetType 'a => set 'a -> set 'a -> bool*)

(* ----------------------- *)
(* Empty set               *)
(* ----------------------- *)

(*val empty : forall 'a. SetType 'a => set 'a*) 
(*val emptyBy : forall 'a. ('a -> 'a -> ordering) -> set 'a*)

(* ----------------------- *)
(* any / all               *)
(* ----------------------- *)

(*val any : forall 'a. SetType 'a => ('a -> bool) -> set 'a -> bool*)

(*val all : forall 'a. SetType 'a => ('a -> bool) -> set 'a -> bool*)


(* ----------------------- *)
(* (IN)                    *)
(* ----------------------- *)

(*val IN [member] : forall 'a. SetType 'a => 'a -> set 'a -> bool*) 
(*val memberBy : forall 'a. ('a -> 'a -> ordering) -> 'a -> set 'a -> bool*)

(* ----------------------- *)
(* not (IN)                *)
(* ----------------------- *)

(*val NIN [notMember] : forall 'a. SetType 'a => 'a -> set 'a -> bool*)



(* ----------------------- *)
(* Emptyness check         *)
(* ----------------------- *)

(*val null : forall 'a. SetType 'a => set 'a -> bool*)


(* ------------------------ *)
(* singleton                *)
(* ------------------------ *)

(*val singleton : forall 'a. SetType 'a => 'a -> set 'a*)


(* ----------------------- *)
(* size                    *)
(* ----------------------- *)

(*val size : forall 'a. SetType 'a => set 'a -> nat*)


(* ----------------------------*)
(* setting up pattern matching *)
(* --------------------------- *)

(*val set_case : forall 'a 'b. SetType 'a => set 'a -> 'b -> ('a -> 'b) -> 'b -> 'b*)


(* ------------------------ *)
(* union                    *)
(* ------------------------ *)

(*val unionBy : forall 'a. ('a -> 'a -> ordering) -> set 'a -> set 'a -> set 'a*)
(*val union : forall 'a. SetType 'a => set 'a -> set 'a -> set 'a*)

(* ----------------------- *)
(* insert                  *)
(* ----------------------- *)

(*val insert : forall 'a. SetType 'a => 'a -> set 'a -> set 'a*)

(* ----------------------- *)
(* filter                  *)
(* ----------------------- *)

(*val filter : forall 'a. SetType 'a => ('a -> bool) -> set 'a -> set 'a*) 
(*let filter P s=  {e | forall (e IN s) | P e}*)


(* ----------------------- *)
(* partition               *)
(* ----------------------- *)

(*val partition : forall 'a. SetType 'a => ('a -> bool) -> set 'a -> set 'a * set 'a*)
val _ = Define `
 (SET_PARTITION P s=  (SET_FILTER P s, SET_FILTER (\ e .  ~ (P e)) s))`;



(* ----------------------- *)
(* split                   *)
(* ----------------------- *)

(*val split : forall 'a. SetType 'a, Ord 'a => 'a -> set 'a -> set 'a * set 'a*)
val _ = Define `
 (SET_SPLIT dict_Basic_classes_Ord_a p s=  (SET_FILTER (
  dict_Basic_classes_Ord_a.isGreater_method p) s, SET_FILTER (dict_Basic_classes_Ord_a.isLess_method p) s))`;


(*val splitMember : forall 'a. SetType 'a, Ord 'a => 'a -> set 'a -> set 'a * bool * set 'a*)
val _ = Define `
 (splitMember dict_Basic_classes_Ord_a p s=  (SET_FILTER (
  dict_Basic_classes_Ord_a.isLess_method p) s, (p IN s), SET_FILTER (
  dict_Basic_classes_Ord_a.isGreater_method p) s))`;


(* ------------------------ *)
(* subset and proper subset *)
(* ------------------------ *)

(*val isSubsetOfBy : forall 'a. ('a -> 'a -> ordering) -> set 'a -> set 'a -> bool*)
(*val isProperSubsetOfBy : forall 'a. ('a -> 'a -> ordering) -> set 'a -> set 'a -> bool*)

(*val isSubsetOf : forall 'a. SetType 'a => set 'a -> set 'a -> bool*)
(*val isProperSubsetOf : forall 'a. SetType 'a => set 'a -> set 'a -> bool*)


(* ------------------------ *)
(* delete                   *)
(* ------------------------ *)

(*val delete : forall 'a. SetType 'a, Eq 'a => 'a -> set 'a -> set 'a*)
(*val deleteBy : forall 'a. SetType 'a => ('a -> 'a -> bool) -> 'a -> set 'a -> set 'a*)


(* ------------------------ *)
(* bigunion                 *)
(* ------------------------ *)

(*val bigunion : forall 'a. SetType 'a => set (set 'a) -> set 'a*)
(*val bigunionBy : forall 'a. ('a -> 'a -> ordering) -> set (set 'a) -> set 'a*)

(*let bigunion bs=  {x | forall (s IN bs) (x IN s) | true}*)

(* ------------------------ *)
(* big intersection         *)
(* ------------------------ *)

(* Shaked's addition, for which he is now forever responsible as a de facto
 * Lem maintainer...
 *)
(*val bigintersection : forall 'a. SetType 'a => set (set 'a) -> set 'a*)
val _ = Define `
 (bigintersection bs= 
  ({x | x | (x IN (BIGUNION bs)) /\ (! (s :: bs). x IN s)}))`;


(* ------------------------ *)
(* difference               *)
(* ------------------------ *)

(*val differenceBy : forall 'a. ('a -> 'a -> ordering) -> set 'a -> set 'a -> set 'a*)
(*val difference : forall 'a. SetType 'a => set 'a -> set 'a -> set 'a*)

(* ------------------------ *)
(* intersection             *)
(* ------------------------ *)

(*val intersection : forall 'a. SetType 'a => set 'a -> set 'a -> set 'a*)
(*val intersectionBy : forall 'a. ('a -> 'a -> ordering) -> set 'a -> set 'a -> set 'a*)


(* ------------------------ *)
(* map                      *)
(* ------------------------ *)

(*val map : forall 'a 'b. SetType 'a, SetType 'b => ('a -> 'b) -> set 'a -> set 'b*) (* before image *)
(*let map f s=  { f e | forall (e IN s) | true }*)

(*val mapBy : forall 'a 'b. ('b -> 'b -> ordering) -> ('a -> 'b) -> set 'a -> set 'b*) 


(* ------------------------ *)
(* bigunionMap              *)
(* ------------------------ *)

(* In order to avoid providing an comparison function for sets of sets,
   it might be better to combine bigunion and map sometimes into a single operation. *)

(*val bigunionMap : forall 'a 'b. SetType 'a, SetType 'b => ('a -> set 'b) -> set 'a -> set 'b*)
(*val bigunionMapBy : forall 'a 'b. ('b -> 'b -> ordering) -> ('a -> set 'b) -> set 'a -> set 'b*)

(* ------------------------ *)
(* mapMaybe and fromMaybe   *)
(* ------------------------ *)

(* If the mapping function returns Just x, x is added to the result
   set. If it returns Nothing, no element is added. *)

(*val mapMaybe : forall 'a 'b. SetType 'a, SetType 'b => ('a -> maybe 'b) -> set 'a -> set 'b*)
val _ = Define `
 (setMapMaybe f s=  
  (BIGUNION (IMAGE (\ x .  (case f x of 
                          SOME y  => {y} 
                        | NONE => EMPTY
                        )) s)))`;


(*val removeMaybe : forall 'a. SetType 'a => set (maybe 'a) -> set 'a*)
val _ = Define `
 (removeMaybe s=  (setMapMaybe (\ x .  x) s))`;


(* ------------------------ *)
(* min and max              *)
(* ------------------------ *)

(*val findMin : forall 'a.  SetType 'a, Eq 'a => set 'a -> maybe 'a*) 
(*val findMax : forall 'a.  SetType 'a, Eq 'a => set 'a -> maybe 'a*)

(* ------------------------ *)
(* fromList                 *)
(* ------------------------ *)

(*val fromList : forall 'a.  SetType 'a => list 'a -> set 'a*) (* before from_list *)
(*val fromListBy : forall 'a.  ('a -> 'a -> ordering) -> list 'a -> set 'a*) 


(* ------------------------ *)
(* Sigma                    *)
(* ------------------------ *)

(*val sigma : forall 'a 'b. SetType 'a, SetType 'b => set 'a -> ('a -> set 'b) -> set ('a * 'b)*)
(*val sigmaBy : forall 'a 'b. (('a * 'b) -> ('a * 'b) -> ordering) -> set 'a -> ('a -> set 'b) -> set ('a * 'b)*)

(*let sigma sa sb=  { (a, b) | forall (a IN sa) (b IN sb a) | true }*)


(* ------------------------ *)
(* cross product            *)
(* ------------------------ *)

(*val cross : forall 'a 'b. SetType 'a, SetType 'b => set 'a -> set 'b -> set ('a * 'b)*)
(*val crossBy : forall 'a 'b. (('a * 'b) -> ('a * 'b) -> ordering) -> set 'a -> set 'b -> set ('a * 'b)*)

(*let cross s1 s2=  { (e1, e2) | forall (e1 IN s1) (e2 IN s2) | true }*)


(* ------------------------ *)
(* finite                   *)
(* ------------------------ *)

(*val finite : forall 'a. SetType 'a => set 'a -> bool*)


(* ----------------------------*)
(* fixed point                 *)
(* --------------------------- *)

(*val leastFixedPoint : forall 'a. SetType 'a 
  => nat -> (set 'a -> set 'a) -> set 'a -> set 'a*)
 val leastFixedPoint_defn = Defn.Hol_multi_defns `
 (leastFixedPoint 0 f x=  x)
/\ (leastFixedPoint ((SUC bound')) f x=  (let fx = (f x) in
                  if fx SUBSET x then x
                  else leastFixedPoint bound' f (fx UNION x)))`;

val _ = Lib.with_flag (computeLib.auto_import_definitions, false) (List.map Defn.save_defn) leastFixedPoint_defn; 
val _ = export_theory()

