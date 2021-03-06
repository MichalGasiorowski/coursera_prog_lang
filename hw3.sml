(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)


(* 1 
Write a function only_capitals that takes a string list and returns a string list that has only
the strings in the argument that start with an uppercase letter. Assume all strings have at least 1
character. Use List.filter, Char.isUpper, and String.sub to make a 1-2 line solution.
*)
fun only_capitals(lst) = List.filter (fn y => Char.isUpper (String.sub(y, 0) ) ) lst 

(* 2
Write a function longest_string1 that takes a string list and returns the longest string in the
list. If the list is empty, return "". In the case of a tie, return the string closest to the beginning of the
list. Use foldl, String.size, and no recursion (other than the implementation of foldl is recursive).
*)
fun longest_string1(lst) = foldl (fn (s1,s2) => if String.size(s1) > String.size(s2) 
												then s1 
												else s2) 
												"" lst
(* 3
Write a function longest_string2 that is exactly like longest_string1 except in the case of ties
it returns the string closest to the end of the list. Your solution should be almost an exact copy of
longest_string1. Still use foldl and String.size.
*)
fun longest_string2(lst) = foldl (fn (s1,s2) => if String.size(s1) >= String.size(s2) 
												then s1 
												else s2) 
												"" lst
(* 4
Write functions longest_string_helper, longest_string3, and longest_string4 such that:
-> longest_string3 has the same behavior as longest_string1 and longest_string4 has the
same behavior as longest_string2.
-> longest_string_helper has type (int * int -> bool) -> string list -> string
(notice the currying). This function will look a lot like longest_string1 and longest_string2
but is more general because it takes a function as an argument.
-> longest_string3 and longest_string4 are defined with val-bindings and partial applications
of longest_string_helper.
*)
fun longest_string_helper f lst = foldl ( fn (s1, s2) => if f (String.size(s1), String.size(s2)) then s1 else s2 ) 
												"" lst
fun longest_string3 lst = 
	let val f = fn (x,y) => x > y
	in
		longest_string_helper f lst
	end

fun longest_string4 lst = 
	let val f = fn (x,y) => x >= y
	in
		longest_string_helper f lst
	end

(* 5
Write a function longest_capitalized that takes a string list and returns the longest string in
the list that begins with an uppercase letter (or "" if there are no such strings). Use a val-binding
and the ML library's o operator for composing functions. Resolve ties like in problem 2.
*)
fun longest_capitalized lst = (longest_string1 o only_capitals)  lst

(* 6
Write a function rev_string that takes a string and returns the string that is the same characters in
reverse order. Use ML's o operator, the library function rev for reversing lists, and two library functions
in the String module. (Browse the module documentation to find the most useful functions.)
*)
fun rev_string str = (String.implode o rev o String.explode) str

(* 7
Write a function first_answer of type ('a -> 'b option) -> 'a list -> 'b (notice the 2 argu-
ments are curried). The first argument should be applied to elements of the second argument in order
until the first time it returns SOME v for some v and then v is the result of the call to first_answer.
If the first argument returns NONE for all list elements, then first_answer should raise the exception
NoAnswer. Hints: Sample solution is 5 lines and does nothing fancy.
*)
fun first_answer f aList = 
	case aList of
		[] => raise NoAnswer
	  | x::xs => case f x of
	  				NONE => first_answer f xs
	  			  | SOME v => v

(* 8
Write a function all_answers of type ('a -> 'b list option) -> 'a list -> 'b list option
(notice the 2 arguments are curried). The first argument should be applied to elements of the second
argument. If it returns NONE for any element, then the result for all_answers is NONE. Else the
calls to the first argument will have produced SOME lst1, SOME lst2, ... SOME lstn and the result of
all_answers is SOME lst where lst is lst1, lst2, ..., lstn appended together (order doesn't matter).
Hints: The sample solution is 8 lines. It uses a helper function with an accumulator and uses @. Note
all_answers f [] should evaluate to SOME [].
*)
fun all_answers f aList =
	let fun helper aList acc = 
		case aList of
			[] => SOME acc
		  | x::xs => case f x of
		  				NONE => NONE
		  			  | SOME vL => helper xs (acc @ vL)
	in
		helper aList []
	end

(* 9
(This problem uses the pattern datatype but is not really about pattern-matching.) A function g has
been provided to you.
(a) Use g to define a function count_wildcards that takes a pattern and returns how many Wildcard
patterns it contains.
(b) Use g to define a function count_wild_and_variable_lengths that takes a pattern and returns
the number of Wildcard patterns it contains plus the sum of the string lengths of all the variables
in the variable patterns it contains. (Use String.size. We care only about variable names; the
constructor names are not relevant.)
(c) Use g to define a function count_some_var that takes a string and a pattern (as a pair) and
returns the number of times the string appears as a variable in the pattern. We care only about
variable names; the constructor names are not relevant.
*)
fun count_wildcards p = g (fn _ => 1) (fn _ => 0) p 

fun count_wild_and_variable_lengths p = g (fn _ => 1) (String.size) p

fun count_some_var (str: string, p: pattern) = g (fn _ => 0) (fn s => if s = str then 1 else 0) p

(* 10
Write a function check_pat that takes a pattern and returns true if and only if all the variables
appearing in the pattern are distinct from each other (i.e., use different strings). The constructor
names are not relevant. Hints: The sample solution uses two helper functions. The first takes a
pattern and returns a list of all the strings it uses for variables. Using foldl with a function that
uses append is useful in one case. The second takes a list of strings and decides if it has repeats.
List.exists may be useful. Sample solution is 15 lines. These are hints: We are not requiring foldl
and List.exists here, but they make it easier.
*)
fun check_pat p =
	let fun get_all_vars p =
		case p of
			Variable v => [v]
		  | TupleP pL => foldl (fn (x, y) => ( get_all_vars(x) @ y) ) [] pL
		  | ConstructorP (_, pp ) => get_all_vars pp
		  | _ => []
		fun has_rep sList =
			case sList of
				[] => false
			  | x::xs => (List.exists (fn s => s = x) xs) orelse has_rep xs
	in
		not ( (has_rep o get_all_vars) p )
	end

(* 11
Write a function match that takes a valu * pattern and returns a (string * valu) list option,
namely NONE if the pattern does not match and SOME lst where lst is the list of bindings if it does.
Note that if the value matches but the pattern has no patterns of the form Variable s, then the result
is SOME []. Hints: Sample solution has one case expression with 7 branches. The branch for tuples
uses all_answers and ListPair.zip. Sample solution is 13 lines. Remember to look above for the
rules for what patterns match what values, and what bindings they produce. These are hints: We are
not requiring all_answers and ListPair.zip here, but they make it easier.
*)
fun match (v: valu, p: pattern) = (* (string * valu) list option *)
	case (p, v) of
		(Wildcard, _ ) => SOME []
	  | (Variable s, _ ) => SOME [(s, v)]
	  | (UnitP, Unit) => SOME []
	  | (ConstP i, Const k) => if i = k then SOME [] else NONE
	  | (TupleP ps, Tuple vs) => if (List.length ps <> List.length vs) then NONE 
	  							else all_answers (match) (ListPair.zip(vs, ps))
	  | (ConstructorP(s1, pp), Constructor(s2, vv)) => if s1=s2 then match(vv,pp) else NONE
	  | _ => NONE

(* 12
Write a function first_match that takes a value and a list of patterns and returns a
(string * valu) list option, namely NONE if no pattern in the list matches or SOME lst where
lst is the list of bindings for the first pattern in the list that matches. Use first_answer and a
handle-expression. Hints: Sample solution is 3 lines.
*)

fun first_match v pList = 
	SOME (first_answer (fn p => match(v, p) ) pList) handle NoAnswer => NONE

(*
(Challenge Problem) Write a function typecheck_patterns that \type-checks" a pattern list. Types
for our made-up pattern language are defined by: ...
typecheck_patterns should have type ((string * string * typ) list) * (pattern list) -> typ option.
The first argument contains elements that look like ("foo","bar",IntT), which means constructor foo
makes a value of type Datatype "bar" given a value of type IntT. Assume list elements all have different
first fields (the constructor name), but there are probably elements with the same second field (the datatype
name). Under the assumptions this list provides, you \type-check" the pattern list to see if there exists
some typ (call it t) that all the patterns in the list can have. If so, return SOME t, else return NONE.
You must return the \most lenient" type that all the patterns can have. For example, given patterns
TupleP[Variable("x"),Variable("y")] and TupleP[Wildcard,Wildcard], return TupleT[Anything,Anything]
even though they could both have type TupleT[IntT,IntT]. As another example, if the only patterns
are TupleP[Wildcard,Wildcard] and TupleP[Wildcard,TupleP[Wildcard,Wildcard]], you must return
TupleT[Anything,TupleT[Anything,Anything]].
*)
(* oh, boy -  here it comes 
fun typecheck_patterns (k: (string*string*typ) list, pL: pattern list) = 1
	
*)