(* Coursera Programming Languages Homework 2  *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

(* 1a
Write a function all_except_option, which takes a string and a string list. Return NONE if the
string is not in the list, else return SOME lst where lst is identical to the argument list except the string
is not in it. You may assume the string is in the list at most once. Use same_string, provided to you,
to compare strings. Sample solution is around 8 lines.
*)
(* all_except_option = fn : string * string list -> string list option *)
fun all_except_option(s, lst) = 
	let fun aux(lst, acc) = 
		case lst of
			[] => NONE
		  | head::rest => if same_string(s, head) then SOME (acc @ rest) else aux(rest, acc@[head])
	in
		aux(lst, [])
	end

(* 1b
Write a function get_substitutions1, which takes a string list list (a list of list of strings, the
substitutions) and a string s and returns a string list. The result has all the strings that are in
some list in substitutions that also has s, but s itself should not be in the result. Example:
get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],
"Fred")
 answer: ["Fredrick","Freddie","F"] 
Assume each list in substitutions has no repeats. The result will have repeats if s and another string are
both in more than one list in substitutions. Example:
get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]],
"Jeff")
 answer: ["Jeffrey","Geoff","Jeffrey"] 
Use part (a) and ML's list-append (@) but no other helper functions. Sample solution is around 6 lines.
*)

fun get_substitutions1 (subL, s) =
	case subL of
		[] => []
	  | head::tail => let val suboptions = all_except_option(s, head) 
	  				  val tailsubL = get_substitutions1(tail, s)
	  				in
	  					case suboptions of
	  						NONE => tailsubL
	  					  |	SOME subs => subs @ tailsubL
	  				end 
	
(*1c 
Write a function get_substitutions2, which is like get_substitutions1 except it uses a tail-recursive
local helper function.
*)
fun get_substitutions2 (subL: string list list , s: string) =
	let fun aux(subL: string list list, acc: string list) = 
		case subL of
			[] => acc
		  | head::tail => let val suboptions = all_except_option(s, head)
		  				  	in
		  				  		case suboptions of
		  				  			NONE => aux(tail, acc)
		  				  		  | SOME subs => aux(tail, acc @ subs)
		  				  	end
		in
			aux(subL, [])
		end
(*1d
Write a function similar_names, which takes a string list list of substitutions (as in parts (b) and
(c)) and a full name of type {first:string,middle:string,last:string} and returns a list of full
names (type {first:string,middle:string,last:string} list). The result is all the full names you
can produce by substituting for the First name (and only the First name) using substitutions and parts (b)
or (c). The answer should begin with the original name (then have 0 or more other names).
*)

fun similar_names(subL: string list list, full_name: {first:string, middle:string, last:string}) = 
	let val {first=x, middle=y, last=z} = full_name
		fun helper (subs) = 
			case subs of 
			[] => []
		  | head::rest => {first=head, middle=y, last=z} :: helper(rest)
	in
		[full_name] @ helper(get_substitutions2(subL, x))
	end
	
(* you may assume that Num is always used with values 2, 3, ..., 9
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)
(* minor helper functions*)

(*count number of cards with rank r *)
fun count_rank(cs: card list, r: rank) =
	let fun helper(cs, acc) =
		case cs of
			[] => acc
		  | (s1, r1)::tail => case r1 = r of
		  							true => helper(tail, acc + 1)
		  						  | false => helper(tail, acc)
	in
		helper(cs, 0)
	end
(* general score  *)	
fun score_general(card_sum, areAllSame, goal: int) = 
	let val sum_minus_goal = card_sum - goal
	in
		case (sum_minus_goal > 0, areAllSame) of
			(true, true) => 3*sum_minus_goal div 2
		  | (true, false) => 3*sum_minus_goal
		  | (false, true) => ~sum_minus_goal div 2
		  | (false, false) => ~sum_minus_goal
	end



(* 2a
Write a function card_color, which takes a card and returns its color (spades and clubs are black,
diamonds and hearts are red). Note: One case-expression is enough. 
*)
fun card_color(c: card) = 
	case c of
		(Clubs , _) => Black
	  | (Spades , _) => Black
	  | _ => Red
(* 2b
Write a function card_value, which takes a card and returns its value (numbered cards have their
number as the value, aces are 11, everything else is 10). Note: One case-expression is enough.
*)
fun card_value(c: card) = 
	case c of
		(_, Ace) => 11
	  | (_, Num v) => v
	  | _ => 10

(* 2c
Write a function remove_card, which takes a list of cards cs, a card c, and an exception e. It returns a
list that has all the elements of cs except c. If c is in the list more than once, remove only the First one.
If c is not in the list, raise the exception e. You can compare cards with =.
*)
fun remove_card(cs: card list, c: card, e) = 
	let fun aux(cs, acc) = 
		case cs of
			[] => raise e
		  | head::rest => if head = c then acc @ rest else aux(rest, acc@[head])
	in
		aux(cs, [])
	end
(* 2d 
Write a function all_same_color, which takes a list of cards and returns true if all the cards in the
list are the same color. Hint: An elegant solution is very similar to one of the functions using nested
pattern-matching in the lectures.
*)
fun all_same_color(cs: card list) = 
	case cs of
		[] => true
	  | c::[] => true
	  | c1::c2::rest => case card_color(c1) = card_color(c2) of
	  						true => all_same_color(c2::rest)
	  	 				  | false => false

(* 2e
Write a function sum_cards, which takes a list of cards and returns the sum of their values. Use a locally
defined helper function that is tail recursive.
*)

fun sum_cards(cs: card list) =
	let fun helper(cs, acc) =
		case cs of
			[] => acc
		  | head::tail => helper(tail, acc + card_value(head))
	in
		helper(cs, 0)
	end

(* 2f 
Write a function score, which takes a card list (the held-cards) and an int (the goal) and computes
the score as described above.
*)
fun score(cs: card list, goal: int) = 
	let val sum_c = sum_cards(cs)
		val areAllSame = all_same_color(cs)
	in
		score_general(sum_c, areAllSame, goal)
	end


(* 2g val officiate = fn : card list * move list * int -> int
Write a function officiate, which \runs a game." It takes a card list (the card-list) a move list
(what the player \does" at each point), and an int (the goal) and returns the score at the end of the
game after processing (some or all of) the moves in the move list in order. Use a locally defined recursive
helper function that takes several arguments that together represent the current state of the game. As
described above:
-> The game starts with the held-cards being the empty list.
-> The game ends if there are no more moves. (The player chose to stop since the move list is empty.)
-> If the player discards some card c, play continues (i.e., make a recursive call) with the held-cards
not having c and the card-list unchanged. If c is not in the held-cards, raise the IllegalMove
exception.
-> If the player draws and the card-list is empty, the game is over. Else if drawing causes the sum of
the held-cards to exceed the goal, the game is over. Else play continues with a larger held-cards
and a smaller card-list.
 *)

fun officiate(cs: card list, mv: move list, goal) = 
	let fun make_play(c_pile: card list, c_held: card list, mv_rem: move list) = 
		case (sum_cards(c_held) - goal > 0, mv_rem) of
			(true, _) =>  score(c_held, goal)
		  | (false, []) => score(c_held, goal)
		  | (false, move::rest) => case (c_pile, move) of
		  							([], Draw) => score(c_held, goal)
		  						  | (_, Discard c) => make_play(c_pile, remove_card(c_held, c, IllegalMove), rest)
		  						  | (top::r_pile , Draw) => make_play(r_pile, c_held @ [top], rest)
	in
		make_play(cs, [], mv)
	end

(* 3a Write score_challenge and officiate_challenge to be like their non-challenge counterparts except
each ace can have a value of 1 or 11 and score_challenge should always return the least (i.e., best)
possible score. Hint: This is easier than you might think. 
print (Int.toString(cand_score)^"\n");
score_general(sum_c, areAllSame, goal)
*)
(* helper function for getting minimum value of card ( Ace -> 1) *)
fun card_value_min(c: card) = 
	case c of
		(_, Ace) => 1
	  | (_, Num v) => v
	  | _ => 10

fun sum_cards_min(cs: card list) =
	let fun helper(cs, acc) =
		case cs of
			[] => acc
		  | head::tail => helper(tail, acc + card_value_min(head))
	in
		helper(cs, 0)
	end

fun score_challenge(cs: card list, goal: int) = 
	let val sum_c = sum_cards(cs)
		val all_aces = count_rank(cs, Ace)
		val areAllSame = all_same_color(cs)
		fun helper(aces_t_out, bestSoFar) = 
			let val cand_score = score_general(sum_c - aces_t_out*10, areAllSame, goal)
			in
				case (aces_t_out > all_aces, cand_score < bestSoFar ) of
					(true, _) => bestSoFar
			  	  | (false, false) => helper(aces_t_out + 1, bestSoFar)
			  	  | (false, true) => helper(aces_t_out + 1, cand_score)
			end
	in
		helper(1, score_general(sum_c , areAllSame, goal))
	end

fun officiate_challenge(cs: card list, mv: move list, goal) = 
	let fun make_play(c_pile: card list, c_held: card list, mv_rem: move list) = 
		case (sum_cards_min(c_held) - goal > 0, mv_rem) of
			(true, _) =>  score_challenge(c_held, goal)
		  | (false, []) => score_challenge(c_held, goal)
		  | (false, move::rest) => case (c_pile, move) of
		  							([], Draw) => score_challenge(c_held, goal)
		  						  | (_, Discard c) => make_play(c_pile, remove_card(c_held, c, IllegalMove), rest)
		  						  | (top::r_pile , Draw) => make_play(r_pile, c_held @ [top], rest)
	in
		make_play(cs, [], mv)
	end

(* 3b
Write careful_player, which takes a card-list and a goal and returns a move-list such that calling
officiate with the card-list, the goal, and the move-list has this behavior:
-> The value of the held cards never exceeds the goal.
-> A card is drawn whenever the goal is more than 10 greater than the value of the held cards.
-> If a score of 0 is reached, there must be no more moves.
-> If it is possible to discard one card, then draw one card to produce a score of 0, then this must be
done. (Note careful_player will have to look ahead to the next card, which in many card games
is considered \cheating.")
*)


(*returns Card with given value, if no such card exist in pile - return (Spades, Num(0))  *)
fun get_card_with_count(cs: card list, value: int) = 
	let fun helper(cs: card list) = 
		case cs of
			[] => (Spades, Num(0))
		  | head::rest => case card_value(head) - value = 0 of
		  					true => head
		  				  | false => helper(rest)
	in
		helper(cs)
	end


fun careful_player(cs: card list, goal: int) = 
	let fun helper(cs_stack: card list, cs_held: card list, mv: move list) = 
		let val held_sum = sum_cards(cs_held)
			val goal_min_sum = goal - held_sum
		in
			case (goal_min_sum = 0, goal_min_sum > 10, cs_stack) of
				(true, _, _) => mv
			  | (false, true, []) => mv
			  | (false, true, top::rest) => helper(rest, cs_held @ [top], mv @ [Draw])
			  | (false, false, []) => mv
			  | (false, false, top::rest) => let val drawn_top_val = card_value(top)
			  									 val searched_val = goal_min_sum - drawn_top_val
			  								 in
			  								 	case searched_val >= 0 of
			  								 		true => helper(rest, cs_held @ [top], mv @ [Draw])
			  								 	  | false => case get_card_with_count(cs_held, ~searched_val) of
			  								 	  			(Spades, Num(0)) => mv
			  								 	  		  | card_found => helper(rest, remove_card(cs_held, card_found, IllegalMove) @ [top], mv @[Discard card_found] @ [Draw] )
			  								 end 
		end
	in
		helper(cs, [], [])
	end
