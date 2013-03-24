(* eval_prog tests with Shift Line*)
use "hw7.sml";

let 
    val Line(a,b) = (eval_prog (preprocess_prog (Shift(3.0, 4.0, Line(4.0,4.0))), []))
    val Line(c,d) = Line(4.0,~4.0) 
in
    if real_close(a,c) andalso real_close(b,d)
    then (print "shift works with Line\n")
    else (print "shift does NOT work with Line\n")
end;

(* eval_prog tests with Shift VerticalLine*)
let 
    val VerticalLine(a) = (eval_prog (preprocess_prog (Shift(3.0, 4.0, VerticalLine(4.0))), []))
    val VerticalLine(c) = VerticalLine(7.0) 
in
    if real_close(a,c)
    then (print "shift works with VerticalLine\n")
    else (print "shift does NOT work with VerticalLine\n")
end;
    
(* eval_prog tests with Shift LineSegment*)
let 
    val LineSegment(a, b, a1, b1) = (eval_prog (preprocess_prog (Shift(3.0, 4.0, LineSegment(4.0, 3.0, 12.0, ~2.0))), []))
    val LineSegment(c, d, c1, d1) = LineSegment(7.0, 7.0, 15.0, 2.0) 
in
    if real_close(a,c) andalso real_close(b, d) andalso real_close(a1, c1) andalso real_close(b1, d1)
    then (print "shift works with LineSegment\n")
    else (print "shift does NOT work with LineSegment\n")
end;