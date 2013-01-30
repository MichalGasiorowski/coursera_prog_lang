use "hw2.sml";

val tests = [
	(*FUN 1a TEST  all_except_option = fn : string * string list -> string list option *)
	("all_except_option('AA', []) = NONE", all_except_option("AA", []) = NONE), 
	("all_except_option('AA', ['BB','CC']) = NONE", all_except_option("AA", ["BB", "CC"]) = NONE),
	("all_except_option('AA', ['AA']) = SOME []", all_except_option("AA", ["AA"]) = SOME []),
	("all_except_option('AA', ['AA', 'BB', 'CC']) = SOME ['BB', 'CC']", all_except_option("AA", ["AA", "BB", "CC"]) = SOME ["BB", "CC"]),
	("all_except_option('AA', ['AA', 'BB']) = SOME ['BB']", all_except_option("AA", ["AA", "BB"]) = SOME ["BB"]),
	(*FUN 1b TEST  val get_substitutions1 = fn : string list list * string -> string list *)
	("get_substitutions1 test from hw2", get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],
	"Fred") = ["Fredrick","Freddie","F"]), 
	("get_substitutions1 edge case1 - no results", get_substitutions1([["Fred","Fredrick"]],"Bob") = [])
];
print "\n------------------------------------------------\n";
fun all_tests(tests) =
	let fun helper(tests: (string*bool) list, all_passed) = 
		case tests of
			[] => all_passed
	  	  | (st, true)::rest =>  (print ("***" ^ st ^" PASSED!!!\n"); helper(rest, all_passed))
	  	  | (st, false)::rest => (print ("***" ^ st ^" FAILED!!!\n"); helper(rest, false))
	in
		helper(tests, true)
	end;

case all_tests(tests) of
	true => print "--------------ALL TESTS PASSED-------------\n"
  | false => print "--------------SOMETHING IS WRONG-------------------------\n"


