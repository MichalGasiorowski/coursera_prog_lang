use "hw1.sml";

val t1 = (1980,4,1);
val t2 = (1945,9,1);
val t3 = (9001,5,4);
val t4 = (1, 1, 1);

val tests = [
	is_older((2012,01,01), (2011,12,31)) = false,
	is_older((2011,12,31), (2012,01,01)) = true
];

fun all_tests(tests: bool list) =
	if null tests
	then true
	else (hd tests) andalso all_tests(tl tests);


all_tests(tests);
 
