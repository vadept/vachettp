module vachettp_router

pub struct Route {
	path string
	file string
	method string
}

pub fn (route Route) get_path() string {
	return route.path
}

pub fn (route Route) get_file() string {
	return route.file
}

pub fn (route Route) get_method() string {
	return route.method
}
