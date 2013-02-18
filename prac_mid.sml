fun mystery f xs =
    let
        fun g xs =
           case xs of
             [] => NONE
           | x::xs' => if f x then SOME x else g xs'
    in	case xs of
            [] => NONE
	  | x::xs' => if f x then g xs' else mystery f xs'
    end

fun alwT(x:int) = (print "DUPA\n";true)

fun null1 xs = case xs of [] => true | _ => false
fun null2 xs = xs=[]
fun null3 xs = if null xs then true else false
fun null xs = ((fn z => false) (hd xs)) handle List.Empty => true


val k = [(4,19), (1,20), (74,75)]
val p = case k of 
	(a,b)::(c,d)::(e,f)::g => true

signature COUNTER =
sig
    type t = int
    val newCounter : int -> t
    val increment : t -> t
end

structure NoNegativeCounter :> COUNTER = 
struct

exception InvariantViolated

type t = int

fun newCounter i = if i <= 0 then 1 else i

fun increment i = i + 1

fun first_larger (i1,i2) =
    if i1 <= 0 orelse i2 <= 0
    then raise InvariantViolated
    else (i1 - i2) > 0

end


