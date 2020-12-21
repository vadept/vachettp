module vachettp_router

fn test_get_path() {
	r := Route{'/foo/bar:bazz', 'index.v', 'foo_bar'}

	assert '/foo/bar:bazz' == r.get_path()
}

fn test_get_file() {
	r := Route{'/foo/bar:bazz', 'index.v', 'foo_bar'}

	assert 'index.v' == r.get_file()
}

fn test_get_method() {
	r := Route{'/foo/bar:bazz', 'index.v', 'foo_bar'}

	assert 'foo_bar' == r.get_method()
}
