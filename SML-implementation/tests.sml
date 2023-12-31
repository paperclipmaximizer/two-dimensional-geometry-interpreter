use "hw7.sml";


fun real_equal(x,y) = Real.compare(x,y) = General.EQUAL;
(* one of two invariants:
1. No LineSegment anywhere in the expression has endpoints that are the same as (i.e., real close to)
each other. Such a line-segment should be replaced with the appropriate Point. For example in ML
syntax, LineSegment(3.2,4.1,3.2,4.1) should be replaced with Point(3.2,4.1).    *)
let
	val LineSegment(a,b,c,d) = preprocess_prog (LineSegment(3.2,4.1,3.2,4.1))
in
	if real_equal(a,c) andalso real_equal(b,d)
	then (print "preprocess converts an improper LineSegment to a Point successfully\n")
    else (print "preprocess does not convert an improper LineSegment to a Point successfully\n")
end;

let
    val Point(a,b) = preprocess_prog (Point(3.2,4.1))
    val Point(c,d) = Point(3.2,4.1)
in
    if real_equal(a,c) andalso real_equal(b,d)
    then (print "preprocess converts a Point to a Point successfully\n")
    else (print "preprocess does not convert a Point to a Point successfully\n")
end;

let
	val LineSegment(a,b,c,d) = preprocess_prog (LineSegment(3.2,4.1,~3.2,~4.1))
	val LineSegment(e,f,g,h) = LineSegment(~3.2,~4.1,3.2,4.1)
in
	if real_equal(a,e) andalso real_equal(b,f) andalso real_equal(c,g) andalso real_equal(d,h)
	then (print "preprocess flips an improper LineSegment successfully\n")
	else (print "preprocess does not flip an improper LineSegment successfully\n")
end;

(* eval_prog tests with Shift*)
let
	val Point(a,b) = (eval_prog (preprocess_prog (Shift(3.0, 4.0, Point(4.0,4.0))), []))
	val Point(c,d) = Point(7.0,8.0)
in
	if real_equal(a,c) andalso real_equal(b,d)
	then (print "eval_prog with empty environment worked\n")
	else (print "eval_prog with empty environment is not working properly\n")
end;

(* Using a Var *)
let
	val Point(a,b) = (eval_prog (Shift(3.0,4.0,Var "a"), [("a",Point(4.0,4.0))]))
	val Point(c,d) = Point(7.0,8.0)
in
	if real_equal(a,c) andalso real_equal(b,d)
	then (print "eval_prog with 'a' in environment is working properly\n")
	else (print "eval_prog with 'a' in environment is not working properly\n")
end;


(* With Variable Shadowing *)
let
	val Point(a,b) = (eval_prog (Shift(3.0,4.0,Var "a"), [("a",Point(4.0,4.0)),("a",Point(1.0,1.0))]))
	val Point(c,d) = Point(7.0,8.0)
in
	if real_equal(a,c) andalso real_equal(b,d)
	then (print "eval_prog with shadowing 'a' in environment is working properly\n")
	else (print "eval_prog with shadowing 'a' in environment is not working properly\n")
end;
