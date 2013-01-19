use "hw1.sml";

val tests = [
	(*FUN 1 TEST  *)
	is_older((2012,01,01), (2011,12,31)) = false,
	is_older((2011,12,31), (2012,01,01)) = true,
	is_older((1000,12,31), (1001,01,01)) = true,
	is_older((1333,12,31), (1200,31,31)) = false,
	is_older((1,2222,2222), (2,01,01)) = true,
	is_older((0,12,31), (1,1,1)) = true,
	is_older((2011,11,31), (2011,11,31)) = true,
	is_older((~2,~5,31), (1,~9,31)) = true,
	is_older((2045,3,4), (2006,5,3)) = false,
	(*FUN 2 TEST  *)
	number_in_month([(2012,1,30), (2034,1,4)], 1) = 2,
	number_in_month([(2010,2,30), (1978,4,5)], 3) = 0,
	number_in_month([], 1) = 0,
	number_in_month([(2012,1,30), (2034,2,4),(2345,1,14),(9000,6,6)], 6) = 1,
	(*FUN 3 TEST  *)
	number_in_months([(2012,1,30), (2034,2,4),(2345,1,14),(9000,6,6)] , [1,2,3]) = 3,
	number_in_months([(1980,2,23), (2034,2,4),(2345,1,14),(9000,3,6)] , [1,2,3]) = 4,
	number_in_months([(2012,1,30), (2034,2,4),(2345,1,14),(9000,6,6)] , [5,7,8]) = 0,
	number_in_months([] , [1,2,3,4,5,7,8]) = 0,
	(*FUN 4 TEST  *)
	dates_in_month([(2012,1,30), (2034,2,4),(2345,1,14),(9000,6,6)], 1) = [(2012,1,30),(2345,1,14)],
	dates_in_month([], 1) = [], 
	dates_in_month([(2012,1,30), (2034,2,4),(2345,1,14),(9000,6,6)], 2) = [(2034,2,4)],
	dates_in_month([(2012,1,30), (2034,2,4),(2345,1,14),(9000,6,6)], 3) = [],
	(*FUN 5 TEST  *)
	dates_in_months([(2012,1,30), (2034,2,4),(2345,1,14),(9000,6,6)], [1,2]) = [(2012,1,30), (2345,1,14),(2034,2,4)],
	dates_in_months([], [1,2]) = [],
	dates_in_months([(1980,2,25), (1410,4,5),(1444,4,22),(1222,2,6)], [4]) = [(1410,4,5),(1444,4,22)],
	dates_in_months([(1980,2,25), (1410,4,5),(1444,4,22),(1222,2,6)], [5,6]) = [],
	(*FUN 6 TEST  *)
	get_nth(["AAA","BBB","CCC", "DDD","EEE"],3) = "CCC",
	get_nth(["AAA","BBB","CCC", "DDD","EEE"],1) = "AAA",
	get_nth(["AAA","BBB","CCC", "DDD","EEE"],5) = "EEE",
	get_nth(["AAA"], 1) = "AAA",
	get_nth(["AAA","BBB"], 2) = "BBB",
	(*FUN 7 TEST  *)
	date_to_string(2012, 1, 1) = "January 1, 2012",
	date_to_string(2000, 8, 23) = "August 23, 2000",
	date_to_string(1, 12, 22) = "December 22, 1",
	date_to_string(1900, 11, 11) = "November 11, 1900",
	date_to_string(1955, 9, 12) = "September 12, 1955",
	date_to_string(2001, 7, 31) = "July 31, 2001",
	date_to_string(1899, 6, 12) = "June 12, 1899",
	(*FUN 8 TEST  *)
	number_before_reaching_sum(1, [1,2]) = 0,
	number_before_reaching_sum(10, [1,2,3,4,5]) = 3,
	number_before_reaching_sum(5, [3,2,4,4,5]) = 1,
	number_before_reaching_sum(2, [1,2,3,4,5]) = 1,
	number_before_reaching_sum(2, [2,2,3,4,5]) = 0,
	number_before_reaching_sum(11, [1,2,3,4,5]) = 4,
	(*FUN 9 TEST  *)
	what_month(1) = 1,  what_month(32) = 2,
	what_month(31) = 1, what_month(355) = 12,
	what_month(50) = 2, what_month(66) = 3,
	what_month(365) = 12, what_month(340) = 12,
	what_month(59) =2, what_month(60) = 3,
	what_month(90) = 3, what_month(91) = 4,
	(*FUN 10 TEST  *)
	month_range(1, 1) = [1], month_range(2, 1) = [],
	month_range(1, 10) = [1,1,1,1,1,1,1,1,1,1], month_range(31, 33) = [1,2,2],
	month_range(364, 365) = [12,12], month_range(333, 340) = [11,11,12,12,12,12,12,12],
	(*FUN 11 TEST  *)
	oldest([]) = NONE, oldest([(1900, 12,1)]) = SOME (1900,12,1), 
	oldest([(1900, 12,1), (1940,12,22)]) = SOME (1940,12,22), oldest([(2000, 1,12), (2000,2,12)]) = SOME (2000,2,12),
	oldest([(2000, 2,13), (2000,2,12)]) = SOME (2000,2,13),
	oldest([(2009, 5,30), (2100,1,15), (1998, 11,16)]) = SOME (2100,1,15),
	(*FUN 12 TEST  *)
	number_in_months_challenge([(2012,1,30), (2034,2,4),(2345,1,14),(9000,6,6)] , [2,1,2,3]) = 3,
	number_in_months_challenge([(1980,2,23), (2034,2,4),(2345,1,14),(9000,3,6)] , [1,1,1,2,3]) = 4,
	number_in_months_challenge([(2012,1,30), (2034,2,4),(2345,1,14),(9000,6,6)] , [5,7,5,7,8,1]) = 2,
	number_in_months_challenge([(2012,1,30), (2034,2,4),(2345,1,14),(9000,6,6)] , [4,4,5,3,3,3]) = 0,

	dates_in_months_challenge([(2012,1,30), (2034,2,4),(2345,1,14),(9000,6,6)], [1,1,11,2]) = [(2012,1,30), (2345,1,14),(2034,2,4)],
	dates_in_months_challenge([], [1,1,2]) = [],
	dates_in_months_challenge([(1980,2,25), (1410,4,5),(1444,4,22),(1222,2,6)], [4,4,5]) = [(1410,4,5),(1444,4,22)],

	(*FUN 13 TEST  *)
	reasonable_date(2000,2,29), reasonable_date(~1,12,29) = false, reasonable_date(2001,2,29) = false,
	reasonable_date(1400,3,1), reasonable_date(1865,3,32) = false, reasonable_date(1678,1, 32) = false,
	reasonable_date(1333,5,31), reasonable_date(2000,0,29) = false, reasonable_date(2000,12,0) = false,
	reasonable_date(0,12,2) = false, reasonable_date(1900,2,29) = false, reasonable_date(1800,2,29) = false,
	reasonable_date(1700,2,29) = false, reasonable_date(1777,11,31) = false, reasonable_date(1600, 2, 29)
];

fun all_tests(tests: bool list) =
	if null tests
	then true
	else (hd tests) andalso all_tests(tl tests);

if all_tests(tests)
	then print "--------------ALL TESTS PASSED-------------\n"
	else print "--------------SOMETHING IS WRONG-------------------------\n"; 
