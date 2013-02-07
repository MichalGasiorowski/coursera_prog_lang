use "hw3.sml";

val tests = [
	(*FUN 1 TEST val only_capitals = fn : string list -> string list *)
	("1: empty test", only_capitals([]) = []),
	("1: 1 el test", only_capitals(["AA"]) = ["AA"]),
	("1: 2 el test", only_capitals(["Gasas","aaa"]) = ["Gasas"]),
	("1: 1 el test", only_capitals(["bAA"]) = []),
	("1: 1 el test", only_capitals(["bAA", "YTR", "Plo"]) = ["YTR", "Plo"]),
	(*FUN 2 TEST val longest_string1 = fn : string list -> string *)
	("2: empty el test", longest_string1([]) = ""),
	("2: 1 el test", longest_string1(["a"]) = "a"),
	("2: 2 el test", longest_string1(["GT", "PPP"]) = "PPP"),
	("2: 2 el test tie", longest_string1(["GTA", "PPP"]) = "GTA"),
	("2: all empty strings", longest_string1(["", ""]) = ""),
	("2: 3 el test tie", longest_string1(["aaa", "bb", "ccc"]) = "aaa"),
	(*FUN 3 TEST val longest_string2 = fn : string list -> string *)  
	("3: empty el test", longest_string2([]) = ""),
	("3: 1 el test", longest_string2(["a"]) = "a"),
	("3: 2 el test", longest_string2(["GT", "PPP"]) = "PPP"),
	("3: 2 el test tie", longest_string2(["GTA", "PPP"]) = "PPP"),
	("3: all empty strings", longest_string2(["", ""]) = ""),
	("3: 3 el test tie", longest_string2(["aaa", "bb", "ccc"]) = "ccc"),
	(*FUN 4 TEST val longest_string3 = fn : string list -> string *)  
	(*FUN 4 TEST val longest_string4 = fn : string list -> string *)  
	("4: empty el test", longest_string3([]) = ""),
	("4: 1 el test", longest_string3(["a"]) = "a"),
	("4: 2 el test", longest_string3(["GT", "PPP"]) = "PPP"),
	("4: 2 el test tie", longest_string3(["GTA", "PPP"]) = "GTA"),
	("4: all empty strings", longest_string3(["", ""]) = ""),
	("4: 3 el test tie", longest_string3(["aaa", "bb", "ccc"]) = "aaa"),
	("4: empty el test", longest_string4([]) = ""),
	("4: 1 el test", longest_string4(["a"]) = "a"),
	("4: 2 el test", longest_string4(["GT", "PPP"]) = "PPP"),
	("4: 2 el test tie", longest_string4(["GTA", "PPP"]) = "PPP"),
	("4: all empty strings", longest_string4(["", ""]) = ""),
	("4: 3 el test tie", longest_string4(["aaa", "bb", "ccc"]) = "ccc"),
	(*FUN 5 TEST val longest_capitalized = fn : string list -> string *)
	("5: empty list test", longest_capitalized([]) = ""),
	("5: 1 el list fail", longest_capitalized(["a"]) = ""),
	("5: 1 el list success", longest_capitalized(["AAA"]) = "AAA"),
	("5: 2 list test", longest_capitalized(["aa", "AA"]) = "AA"),
	("5: 2 list test", longest_capitalized(["FF", "GGG"]) = "GGG"),
	("5: 2 list test tie", longest_capitalized(["AA", "BB"]) = "AA"),
	(*FUN 6 TEST val rev_string = fn : string -> string *)
	("6: empty string", rev_string "" = ""),
	("6: 1 length str", rev_string "a" = "a"),
	("6: 2 el string", rev_string "aa" = "aa"),
	("6: 2 el string", rev_string "ab" = "ba"),
	("6: 3 string", rev_string "abc" = "cba"),
	("6: 4 string", rev_string "anna" = "anna"),
	(*FUN 7 TEST val first_answer = fn : ('a -> 'b option) -> 'a list -> 'b *)
	("7: empty",( first_answer (fn a => if String.size a > 3 then SOME a else NONE ) []  handle NoAnswer => "") 
		= ""),
	("7: 1 el",( first_answer (fn a => if String.size a > 3 then SOME a else NONE ) ["aa"]  handle NoAnswer => "") 
		= ""),
	("7: 3 el",( first_answer (fn a => if String.size a > 3 then SOME a else NONE ) ["aa","ttt", "AAAA"] handle NoAnswer => "" ) 
		= "AAAA"),
	(*FUN 8 TEST val all_answers = fn : ('a -> 'b list option) -> 'a list -> 'b list option *)
	("8: empty",( all_answers (fn a => if String.size a > 3 then SOME (String.explode a) else NONE ) []  ) 
		= SOME []),
	("8: empty",( all_answers (fn a => if String.size a > 3 then SOME (String.explode a) else NONE ) ["aa"]  ) 
		= NONE),
	("8: empty",( all_answers (fn a => if String.size a > 3 then SOME (String.explode a) else NONE ) ["AAAA"]  ) 
		= SOME [#"A",#"A",#"A",#"A"] ),
	(*FUN 9 TEST val count_wildcards = fn : pattern -> int *)
	("9a: No wildcards", count_wildcards UnitP = 0),
	("9a: 1 wildcard", count_wildcards Wildcard = 1),
	("9a: Variable", count_wildcards (Variable "aa") = 0),
	("9a: ConstP", count_wildcards (ConstP 4) = 0),
	("9a: TupleP basic", count_wildcards (TupleP [Wildcard] ) = 1),
	("9a: TupleP nested", count_wildcards (TupleP [Wildcard, UnitP, (TupleP [Wildcard])] ) = 2),
	("9a: ConstructorP basic", count_wildcards (ConstructorP ("a", UnitP) ) = 0),
	("9a: ConstructorP basic", count_wildcards (ConstructorP ("a", Wildcard) ) = 1),
	("9a: ConstructorP basic", count_wildcards (ConstructorP ("a", (ConstructorP ("b", Wildcard ) ) ) ) = 1),
	(*FUN 9b TEST val count_wild_and_variable_lengths = fn : pattern -> int *)
	("9b: 1 wildcard ", count_wild_and_variable_lengths (TupleP [Wildcard] ) = 1),
	("9b: 2 wildcard ", count_wild_and_variable_lengths (TupleP [Wildcard, UnitP, (TupleP [Wildcard])] ) = 2),
	("9b: wildcard and variable ", count_wild_and_variable_lengths (TupleP [Wildcard, (Variable "aa")] ) = 3),
	("9b: 1 wildcard and constructorP ", count_wild_and_variable_lengths (ConstructorP ("a", (ConstructorP ("b", Wildcard ) ) ) ) = 1),
	("9b: 1 wildcard and constructorP ", count_wild_and_variable_lengths (ConstructorP ("a", 
		(ConstructorP ("b", (TupleP [(Variable "aa")] ) ) ) ) ) = 2),
	(*FUN 9c TEST val count_some_var = fn : string * pattern -> int *)
	("9c: non matching var ", count_some_var ("a", (ConstructorP ("a", 
		(ConstructorP ("b", (TupleP [(Variable "aa")] ) ) ) ) ) )= 0),
	("9c: 1 wildcard and constructorP ", count_some_var ("A", (ConstructorP ("a", 
		(ConstructorP ("b", (TupleP [(Variable "A")] ) ) ) ) ) )= 1),
	("9c: 1 wildcard and constructorP ", count_some_var ("aa", (ConstructorP ("a", 
		(ConstructorP ("b", (TupleP [(Variable "aa"),(Variable "aa")] ) ) ) ) ) )= 2)

];
print "\n------------------------------------------------\n";
fun all_tests(tests) =
	let fun helper(tests: (string*bool) list, all_passed) = 
		case tests of
			[] => all_passed
	  	  | (st, true)::rest =>  (print ("***" ^ st ^" !!!PASSED!!!\n"); helper(rest, all_passed))
	  	  | (st, false)::rest => (print ("***" ^ st ^" !!!FAILED!!!\n"); helper(rest, false))
	in
		helper(tests, true)
	end;

case all_tests(tests) of
	true => print "--------------EVERY TESTS PASSED-------------\n"
  | false => print "--------------SOMETHING IS WRONG-------------------------\n"


