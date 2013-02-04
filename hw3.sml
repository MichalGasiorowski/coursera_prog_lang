(* Coursera Programming Languages Homework 3 *)

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
fun longest_string_helper
