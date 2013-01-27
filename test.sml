val e = {bar = (1 +2, true andalso true), foo = 3+4, baz=(false,9)}

datatype mytype = TwoInts of int* int
	| Str of string
	| Pizza

fun f x = 
	case x of
		Pizza => 3
		| TwoInts(i1,i2) => i1 + i2
		| Str s => String.size s

datatype suit = Club | Diamond | Heart | Spade
datatype rank = Jack | Queen | King | Ace | Num of int

type card = suit * rank

datatype exp = Constant of int
			| Negate of exp
			| Add of exp * exp
			| Multiply of exp * exp

fun eval e =
	case e of
		Constant i => i
	  | Negate e2  => ~ (eval e2)
	  | Add(e1,e2) => (eval e1) + (eval e2)
	  | Multiply(e1,e2) => (eval e1) * (eval e2)

datatype my_int_list = Empty
	| Cons of int * my_int_list

fun append_mylist (xs, ys) = 
	case xs of 
		Empty => ys
	  | Cons(x, xs') => Cons(x, append_mylist(xs', ys))

fun inc_of_zero intoption = 
	case intoption of
		NONE => 0
	  | SOME i => i +1

fun sum_list xs =
	case xs of
		[] => 0
	  | x::xs' => x + sum_list xs'

fun full_name ( r: {first:string, middle:string, last:string}) =
	let val {first=x, middle=y,last=z} = r
	in
		x ^ " " ^ y ^ " " ^z
	end
	
fun sum_triple (triple : int*int*int) = 
	let val (x,y,z) = triple
	in
		x + y + z
	end

fun is_three x = if x=3 then "yes" else "no"

fun len xs = 
	case xs of
		[] => 0
	  | _::xs' => 1 + len xs'

fun nondecreasing intlist =
	case intlist of
		[] => true
	  | _::[] => true
	  | head::(neck::rest) => (head <= neck andalso nondecreasing (neck::rest))

fun sum2 xs = 
	let fun f (xs, acc) =
		case xs of
			[] => acc
		  | i::xs' => f(xs', i + acc)
	in
		f(xs,0)
	end

fun rev2 lst =
	let fun aux(lst,acc) =
			case lst of
				[] => acc
			  | x::xs => aux(xs, acc@[x])
	in
		aux(lst,[])
	end

