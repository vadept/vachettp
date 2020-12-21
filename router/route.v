module vachettp_router

pub struct Route {
	path string
	controller T
	method string
}

pub fn (route Route) get_path() string {
	return route.path
}

pub fn (route Route) get_controller() T {
	return route.controller
}

pub fn (route Route) get_method() string {
	return route.method
}
