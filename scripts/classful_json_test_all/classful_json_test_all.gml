///@func classful_json_test_all()
function classful_json_test_all() {
	global.__test_fails__ = 0;
	var timeA, timeB;
	timeA = current_time;
	
	/* v Tests here v */
    classful_json_test_encode();
    classful_json_test_decode();
    classful_json_test_files();
	/* ^ Tests here ^ */
	
	timeB = current_time;
	show_debug_message("Classful JSON tests done in " + string(timeB-timeA) + "ms.");
	return global.__test_fails__ == 0;
}
