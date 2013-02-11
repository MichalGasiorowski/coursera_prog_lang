use "hw3.sml";

fun have_same_items l1 l2 = (* return true if l1 has the same items than l2 *)
    case l1 of
    head :: tail => not (List.exists (fn x => x = head) l2) 
                 orelse have_same_items tail l2
      | []           => true

fun same_items (lo1, lo2) =
    case (lo1, lo2) of
    (NONE, NONE)       => true
      | (SOME l1, SOME l2) => have_same_items l1 l2
      | _                  => false

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
	("9aa: No wildcards", count_wildcards UnitP = 0),
	("9ab: 1 wildcard", count_wildcards Wildcard = 1),
	("9ac: Variable", count_wildcards (Variable "aa") = 0),
	("9ad: ConstP", count_wildcards (ConstP 4) = 0),
	("9ae: TupleP basic", count_wildcards (TupleP [Wildcard] ) = 1),
	("9af: TupleP nested", count_wildcards (TupleP [Wildcard, UnitP, (TupleP [Wildcard])] ) = 2),
	("9ag: ConstructorP basic", count_wildcards (ConstructorP ("a", UnitP) ) = 0),
	("9ah: ConstructorP basic+", count_wildcards (ConstructorP ("a", Wildcard) ) = 1),
	("9ai: ConstructorP basic++", count_wildcards (ConstructorP ("a", (ConstructorP ("b", Wildcard ) ) ) ) = 1),
	(*FUN 9b TEST val count_wild_and_variable_lengths = fn : pattern -> int *)
	("9ba: 1 wildcard ", count_wild_and_variable_lengths (TupleP [Wildcard] ) = 1),
	("9bb: 2 wildcard ", count_wild_and_variable_lengths (TupleP [Wildcard, UnitP, (TupleP [Wildcard])] ) = 2),
	("9bc: wildcard and variable ", count_wild_and_variable_lengths (TupleP [Wildcard, (Variable "aa")] ) = 3),
	("9bd: 1 wildcard and constructorP ", count_wild_and_variable_lengths (ConstructorP ("a", (ConstructorP ("b", Wildcard ) ) ) ) = 1),
	("9be: 1 wildcard and constructorP ", count_wild_and_variable_lengths (ConstructorP ("a", 
		(ConstructorP ("b", (TupleP [(Variable "aa")] ) ) ) ) ) = 2),
	(*FUN 9c TEST val count_some_var = fn : string * pattern -> int *)
	("9ca: non matching var ", count_some_var ("a", (ConstructorP ("a", 
		(ConstructorP ("b", (TupleP [(Variable "aa")] ) ) ) ) ) )= 0),
	("9cb: 1 wildcard and constructorP ", count_some_var ("A", (ConstructorP ("a", 
		(ConstructorP ("b", (TupleP [(Variable "A")] ) ) ) ) ) )= 1),
	("9cd: 1 wildcard and constructorP ", count_some_var ("aa", (ConstructorP ("a", 
		(ConstructorP ("b", (TupleP [(Variable "aa"),(Variable "aa")] ) ) ) ) ) )= 2),
	(*10 TEST val check_pat = fn : pattern -> bool *)
	("10: 10a ", check_pat (TupleP [Wildcard] ) = true),
	("10: 10b ", check_pat ((Variable "aa") ) = true),
	("10: 10c ", check_pat (TupleP [(Variable "aa"), (Variable "a") ] ) = true),
	("10: 10c ", check_pat (TupleP [(Variable "aa"), (Variable "aa") ] ) = false),
	("10: 10e ", check_pat (ConstructorP ("a", 
		(ConstructorP ("b", (TupleP [(Variable "aa")] ) ) ) ) )  = true),
	(*11 TEST val match = fn : valu * pattern -> (string * valu) list option *)	
	("11: 11a ",same_items(match(Const 10, Wildcard), SOME []) ),
   	("11: 11b  ",same_items(match(Unit, Wildcard), SOME []) ),
   	("11: 11c  ",same_items(match(Constructor("Test", Unit), Wildcard), SOME []) ),
   	("11: 11d  ",same_items(match(Tuple [Unit, Const 10], Wildcard), SOME []) ),
   	("11: 11e  ",same_items(match(Unit, UnitP), SOME []) ),
   	("11: 11f  ",same_items(match(Const 10, ConstP 10), SOME []) ),
   	("11: 11g  ",same_items(match(Const 10, ConstP 20), NONE) ),
   	("11: 11h  ",same_items(match(Const 10, Variable "x"), SOME [("x",Const 10)]) ),
   	("11: 11i  ",same_items(match(Constructor("Test", Const 35),
            ConstructorP("Test", Variable "y")), SOME [("y",Const 35)]) ),
   	("11: 11j  ", same_items(match(Constructor("Test", Const 35), 
            ConstructorP("Fail", Variable "y")), NONE) ),
   	("11: 11k  ",same_items(match(Tuple([Const 1, Const 2]), 
            TupleP([Variable "x", Variable "y", Variable "z"])), NONE) ),
    ("11: 11l  ",same_items(match(Tuple [Const 1, Const 2, Const 3, Const 4], 
            TupleP [Variable "w",Variable "x", Variable "y", 
                Variable "z"]) , 
          SOME [("z",Const 4),("y",Const 3),("x",Const 2),("w",Const 1)]) ),
    ("11: 11m  ",same_items(match(Tuple [Const 1, Const 2, Const 3, Const 4], 
            TupleP [ConstP 1,Variable "x", ConstP 3, Variable "z"]),
          SOME [("z",Const 4),("x",Const 2)]) ),
    ("11: 11n  ", same_items(
     match(Constructor("A", 
               Tuple([Unit, Const 10, Const 20, 
                  Tuple([Unit, 
                     Constructor("B", Const 30)])])), 
       ConstructorP("A", 
            TupleP([UnitP, Variable "x", ConstP 20, 
                TupleP([UnitP, 
                    ConstructorP("B", 
                             Variable "y")])]))),
     SOME [("y", Const 30), ("x", Const 10)]) ),
    (* 12 TEST val first_match = fn : valu -> pattern list -> (string * valu) list option *)
    ("12: 12a  ", first_match (Const 10) [ConstP 10, Variable "x"] = SOME [] ),
    ("12: 12b  ", first_match (Const 10) [Variable "x", ConstP 10] = SOME [("x",Const 10)] ),
    ("12: 12c  ", first_match (Const 10) [Variable "x", Variable "y"] = SOME [("x",Const 10)] ),     
    ("12: 12d  ", first_match (Const 10) [UnitP, ConstructorP("Test", ConstP 10), Wildcard, 
                 Variable "y", ConstP 10] = SOME [] ),
    ("12: 12e  ", first_match (Const 10) [UnitP, ConstructorP("Test", ConstP 10), 
                 Variable "y", Wildcard, ConstP 10] = SOME [("y", Const 10)] ), 
    ("12: 12f  ",  first_match (Const 10) [UnitP] = NONE ),
    ("12: 12g  ", first_match (Constructor ("foo", Unit)) [ConstructorP("foo", UnitP)] =
       SOME [] ),
    ("12: 12h  ",  first_match (Constructor ("foo", Unit)) [ConstructorP("bar", UnitP)] = NONE )
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
  | false => print "--------------SOMETHING IS WRONG-------------------------\n";



