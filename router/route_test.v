module vachettp_router

struct Controller_test {
}

pub fn (ct Controller_test) index() {}

fn test_get_path() {
	r := Route{'/foo/bar:bazz', Controller_test{}, 'foo_bar'}

	assert '/foo/bar:bazz' == r.get_path()
}

fn test_get_file() {
	r := Route{'/foo/bar:bazz', Controller_test{}, 'foo_bar'}

	assert 'index.v' == r.get_controller()
}

fn test_get_method() {
	r := Route{'/foo/bar:bazz', Controller_test{}, 'foo_bar'}

	assert 'foo_bar' == r.get_method()
}
