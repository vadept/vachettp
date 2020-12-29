module vachettp_router

pub struct Controller_test{}

pub fn (c Controller_test) index() {}

fn test_get_path() {
	r := Route{'/foo/bar:bazz', 'vachettp.Controller_test', 'foo_bar'}
	assert '/foo/bar:bazz' == r.get_path()
}

fn test_get_controller_name() {
	r := Route{'/foo/bar:bazz', 'vachettp.Controller_test', 'foo_bar'}
	assert 'vachettp.Controller_test' == r.get_controller_name()
}

fn test_get_function_name() {
	r := Route{'/foo/bar:bazz', 'vachettp.Controller_test', 'foo_bar'}
	assert 'foo_bar' == r.get_function_name()
}
