use "hw2.sml";

val tests = [
	(*FUN 1a TEST val all_except_option = fn : string * string list -> string list option *)
	("1a: all_except_option('AA', []) = NONE", all_except_option("AA", []) = NONE), 
	("1a: all_except_option('AA', ['BB','CC']) = NONE", all_except_option("AA", ["BB", "CC"]) = NONE),
	("1a: all_except_option('AA', ['AA']) = SOME []", all_except_option("AA", ["AA"]) = SOME []),
	("1a: all_except_option('AA', ['AA', 'BB', 'CC']) = SOME ['BB', 'CC']", all_except_option("AA", ["AA", "BB", "CC"]) = 
		SOME ["BB", "CC"]),
	("1a: all_except_option('AA', ['AA', 'BB']) = SOME ['BB']", all_except_option("AA", ["AA", "BB"]) = SOME ["BB"]),
	(*FUN 1b TEST  val get_substitutions1 = fn : string list list * string -> string list *)
	("1b: get_substitutions1 test from hw2", get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],
	"Fred") = ["Fredrick","Freddie","F"]), 
	("1b: get_substitutions1 edge case1 - no results", get_substitutions1([["Fred","Fredrick"]],"Bob") = []), 
	("1b: get_substitutions1 tricky case with repetition", get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],
		["Geoff","Jeff","Jeffrey"]], "Jeff") = ["Jeffrey","Geoff","Jeffrey"] ),
	("1b: Another tricky case - empty substitution lists", get_substitutions1([],"Fred") = []),
	("1b: Another tricky case - empty ALL", get_substitutions1([],"") = []),
	("1b: Another tricky case - only one value", get_substitutions1([["Fred"]], "Fred") = []),
	("1b: Another tricky case - only one value x2", get_substitutions1([["Fred"], ["Fred"]], "Fred") = []),
	(*FUN 1c TEST val get_substitutions2 = fn : string list list * string -> string list *)
	("1c: get_substitutions2 test from hw2", get_substitutions2([["Fred","Fredrick"], ["Elizabeth","Betty"], 
		["Freddie","Fred","F"]], "Fred") = ["Fredrick","Freddie","F"]), 
	("1c: get_substitutions2 edge case1 - no results", get_substitutions2([["Fred","Fredrick"]],"Bob") = []), 
	("1c: get_substitutions2 tricky case with repetition", get_substitutions2([["Fred","Fredrick"],["Jeff","Jeffrey"], 
		["Geoff","Jeff","Jeffrey"]], "Jeff") = ["Jeffrey","Geoff","Jeffrey"] ),
	("1c: Another tricky case - empty substitution lists", get_substitutions2([],"Fred") = []),
	("1c: Another tricky case - empty ALL", get_substitutions2([],"") = []),
	("1c: Another tricky case - only one value", get_substitutions2([["Fred"]], "Fred") = []),
	("1c: Another tricky case - only one value x2", get_substitutions2([["Fred"], ["Fred"]], "Fred") = []),
	(* FUN 1d TEST val similar_names = fn : string list list * {first:string, last:string, middle:string} -> 
		{first:string, last:string, middle:string} list*)
	("1d: Basic test for similar_names", similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],
	{first="Fred", middle="W", last="Smith"}) = [{first="Fred", last="Smith", middle="W"},
												{first="Fredrick", last="Smith", middle="W"},
												{first="Freddie", last="Smith", middle="W"},
												{first="F", last="Smith", middle="W"}]),
	("1d: Edge test for similar_names : empty subL", similar_names([], {first="Fred", middle="W", last="Smith"}) = 
		[{first="Fred", middle="W", last="Smith"}]),
	("1d: Edge test for similar_names : useless subL", similar_names([["Elizabeth","Betty"]], 
		{first="Fred", middle="W", last="Smith"}) = [{first="Fred", middle="W", last="Smith"}]),
	("1d: Edge test for similar_names : one el matching subL", similar_names([["Fred"], ["Elizabeth","Betty"]], 
		{first="Fred", middle="W", last="Smith"}) = [{first="Fred", middle="W", last="Smith"}]),
	(* FUN 2a TEST val card_color = fn : card -> color *)
	("2a: card_color: testing Spades", card_color(Spades, Queen) = Black), 
	("2a: card_color: testing Hearts", card_color(Hearts, Num(3)) = Red),
	("2a: card_color: testing Clubs", card_color(Clubs, Jack) = Black), 
	("2a: card_color: testing Diamonds", card_color(Diamonds, Num(10)) = Red),
	(* FUN 2b TEST val card_value = fn : card -> int *)
	("2b: card_value: testing Ace", card_value((Spades, Ace)) = 11),
	("2b: card_value: testing King", card_value((Diamonds, King)) = 10),
	("2b: card_value: testing Queen", card_value((Hearts, Queen)) = 10),
	("2b: card_value: testing Jack", card_value((Clubs, Jack)) = 10),
	("2b: card_value: testing Ten", card_value((Spades, Num(10))) = 10),
	("2b: card_value: testing Nine", card_value((Diamonds,Num(9))) = 9),
	("2b: card_value: testing Eight", card_value((Hearts, Num(8))) = 8),
	("2b: card_value: testing Seven", card_value((Clubs, Num(7))) = 7),
	("2b: card_value: testing Six", card_value((Spades, Num(6))) = 6),
	("2b: card_value: testing Five", card_value((Diamonds, Num(5))) = 5),
	("2b: card_value: testing Four", card_value((Hearts, Num(4))) = 4),
	("2b: card_value: testing Three", card_value((Spades, Num(3))) = 3),
	("2b: card_value: testing Two", card_value((Clubs, Num(2))) = 2),
	(* FUN 2c TEST val remove_card = fn : card list * card * exn -> card list *)
	("2c: remove_card: 1 card from 2", remove_card([(Clubs,Jack),(Spades,Num(8))], (Clubs,Jack), IllegalMove) = [(Spades, Num(8))]), 
	("2c: remove_card: 1 card from 2", remove_card([(Clubs,Jack),(Spades,Num(8))], (Spades,Num(8)), IllegalMove) = [(Clubs,Jack)]),
	("2c: remove_card: 1 card from list of 1", remove_card([(Spades,Num(8))], (Spades,Num(8)), IllegalMove) = []),
	("2c: remove_card: ", (remove_card([(Spades,Num(8))], (Spades,Num(7)), IllegalMove) handle IllegalMove => 
		[(Clubs, Num(0))]) = [(Clubs, Num(0))]),
	("2c: remove_card: list empty ", (remove_card([], (Spades,Num(7)), IllegalMove) handle IllegalMove => 
		[(Clubs, Num(0))]) = [(Clubs, Num(0))]), 
	(* FUN 2d TEST val all_same_color = fn : card list -> bool *)
	("2d: all_same_color: empty list", all_same_color([]) = true),
	("2d: all_same_color: 1 card in list", all_same_color([(Spades, Jack)]) = true),
	("2d: all_same_color: 2 cards list", all_same_color([(Spades, Jack), (Clubs, King)]) = true),
	("2d: all_same_color: 2 cards list", all_same_color([(Diamonds, Num(3)), (Clubs, Queen)]) = false),
	("2d: all_same_color: 4 cards list", all_same_color([(Diamonds, Num(3)), (Hearts, Queen), (Diamonds, King), 
		(Diamonds, Ace)]) = true),
	("2d: all_same_color: 5 cards list", all_same_color([(Diamonds, Num(3)), (Diamonds, Queen), (Diamonds, King), 
		(Diamonds, Ace), (Hearts, Num(5))]) = true),
	(* FUN 2e TEST val sum_cards = fn : card list -> int *)
	("2e: sum_cards: empty list", sum_cards([]) = 0),
	("2e: sum_cards: 1 el list", sum_cards([(Diamonds, Num(3))]) = 3),
	("2e: sum_cards: 1 el list", sum_cards([(Spades, Num(10))]) = 10),
	("2e: sum_cards: 2 el list", sum_cards([(Clubs, Num(3)), (Hearts, Ace)]) = 14),
	("2e: sum_cards: 4 el list", sum_cards([(Clubs, Ace), (Diamonds, Ace), (Hearts, Ace), (Spades, Ace)]) = 44),
	("2e: sum_cards: 4 el list", sum_cards([(Clubs, Ace), (Diamonds, Queen), (Hearts, King), (Spades, Ace)]) = 42),
	(* FUN 2f TEST val score = fn : card list * int -> int *)
	("2f: score: empty list", score([], 10) = 5),
	("2f: score: empty list 2", score([], 100) = 50),
	("2f: score: 1 el list, under goal", score([(Clubs, Num(3))], 6) = 1),
	("2f: score: 1 el list, exactly goal", score([(Clubs, Num(3))], 3) = 0),
	("2f: score: 1 el list, over goal", score([(Clubs, Ace)], 6) = 7),
	("2f: score: 1 el list, over goal", score([(Clubs, Ace)], 12) = 0),
	("2f: score: 2 el list, exactly goal", score([(Clubs, Ace), (Diamonds, King)], 21) = 0),
	("2f: score: 2 el list, under goal", score([(Clubs, Ace), (Diamonds, King)], 23) = 2),
	("2f: score: 2 el list, under goal", score([(Clubs, Ace), (Diamonds, Num(6))], 21) = 4), 
	("2f: score: 2 el list, under goal", score([(Clubs, Queen), (Clubs, Num(6))], 21) = 2),
	("2f: score: 3 el list, under goal", score([(Clubs, Jack), (Diamonds, Num(6)), (Spades, Num(2))], 21) = 3),
	("2f: score: 4 el list, waaay over goal", score([(Clubs, Jack), (Diamonds, Num(6)), (Spades, Num(2)), (Hearts, Ace)], 11) = 54),
	(* FUN 2g TEST val officiate = fn : card list * move list * int -> int *)
	("2g: officiate: 1 card list, no moves", officiate([(Clubs, Num(3))], [], 10) = 5),
	("2g: officiate: 1 card list, 1 move", officiate([(Clubs, Num(3))], [Draw], 10) = 3), 
	("2g: officiate: 1 card list, no moves", (officiate([(Clubs,Jack),(Spades,Num(8))], [Draw,Discard(Hearts,Jack)], 42) 
									handle IllegalMove => 666 )= 666),
	("2g: officiate: 1 card list, no moves", (officiate([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)], 
				[Draw,Draw,Draw,Draw,Draw], 42) handle IllegalMove => 666 ) = 3),
	("2g: officiate: 4 card list, some moves", (officiate([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)], 
				[Draw,Discard(Clubs,Ace),Draw, Discard(Spades,Ace),Draw], 42) handle IllegalMove => 666 ) = 15),
	(* FUN 3a TEST val score_challenge = fn : card list * int -> int *)
	("3a: score_challenge: 1 Ace", score_challenge([(Clubs, Ace), (Diamonds, Num(6))], 7) = 0), 
	("3a: score_challenge: 2 Ace", score_challenge([(Clubs, Ace), (Diamonds, Ace)], 5) = 3),
	("3a: score_challenge: 2 Ace", score_challenge([(Clubs, Ace), (Diamonds, Ace)], 12) = 0),
	("3a: score_challenge: 1 Ace same suit", score_challenge([(Spades, Ace), (Spades, King), (Spades, Num(4))], 17) = 1),
	("3a: score_challenge: 1 Ace same suit", score_challenge([(Clubs, Ace), (Diamonds, Ace), (Hearts, Ace), (Spades, Ace)], 5) = 1),
	("3a: officiate_challenge: 1 card list, no moves", officiate_challenge( [(Clubs, Ace)], [], 10) = 5),
	("3a: officiate_challenge: 1 card list, 1 move", officiate_challenge([(Clubs, Ace)], [Draw], 2) = 0), 
	("3a: officiate_challenge: 1 card list, no moves", (officiate_challenge([(Clubs,Jack),(Spades,Num(8))], [Draw,Discard(Hearts,Jack)], 11) 
									handle IllegalMove => 666 )= 666),
	("3a: officiate_challenge: 1 card list, no moves", (officiate_challenge([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)], 
				[Draw,Draw,Draw,Draw,Draw], 10) handle IllegalMove => 666 ) = 3),
	("3a: officiate_challenge: 4 card list, some moves", (officiate_challenge([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)], 
				[Draw,Discard(Clubs,Ace),Draw, Discard(Spades,Ace),Draw], 4) handle IllegalMove => 666 ) = 1),
	(* 3b TEST val careful_player = fn: card list * int -> move list  *)
	("3b: careful_player: ", careful_player([], 3) = []), 
	("3b: careful_player: ", careful_player([(Clubs, Ace), (Diamonds, Num(6))], 12) = [Draw]),
	("3b: careful_player: ", careful_player([(Clubs, King), (Diamonds, Num(6))], 6) = []),
	("3b: careful_player: ", careful_player([(Clubs, Num(2)), (Diamonds, Num(3))], 6) = [Draw, Draw]),
	("3b: careful_player: ", careful_player([(Clubs, Num(2)), (Diamonds, Num(3)), (Spades, King)], 13) = 
		[Draw, Draw, Discard(Clubs, Num(2)), Draw]),
	("3b: careful_player: ", careful_player([(Clubs, Num(2)), (Diamonds, Num(3))], 3) = [Draw, Discard(Clubs, Num(2)), Draw])  
	
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


