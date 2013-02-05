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
	(*FUN 4 TEST val longest_capitalized = fn : string list -> string *)
	("5: empty list test", longest_capitalized([]) = ""),
	("5: 1 el list fail", longest_capitalized(["a"]) = ""),
	("5: 1 el list success", longest_capitalized(["AAA"]) = "AAA"),
	("5: 2 list test", longest_capitalized(["aa", "AA"]) = "AA"),
	("5: 2 list test", longest_capitalized(["FF", "GGG"]) = "GGG"),
	("5: 2 list test tie", longest_capitalized(["AA", "BB"]) = "AA")
	
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


