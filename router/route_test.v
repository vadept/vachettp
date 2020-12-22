module vachettp_router

fn compare<T>(a T, b T) int {
	if a < b {
		return -1
	}
	if a > b {
		return 1
	}
	return 0
}

// struct Controller_test {
// }

// pub fn (ct Controller_test) index() {}

fn test_get_path() {
	// assert 1 == compare(1, 0)
	

	// r := create_route<Controller_test>('/foo/bar:bazz', 'foo_bar')
	assert true
	// assert '/foo/bar:bazz' == r.get_path()
}

// TODO: uncomment when this will be resolved : https://github.com/vlang/v/issues/7445
// fn test_get_file() {
// 	r := create_route<Controller_test>('/foo/bar:bazz', 'foo_bar')

//  	assert 'vachettp_router.Controller_test' == r.get_controller_type()
// }

// fn test_get_function_name() {
// 	r := create_route<Controller_test>('/foo/bar:bazz', 'foo_bar')

// 	assert 'foo_bar' == r.get_function_name()
// }
