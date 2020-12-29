module vachettp_router

pub struct Route {
	path string
	controller string
	function string
}

pub fn (route Route) get_path() string {
	return route.path
}

pub fn (route Route) get_controller_name() string {
	return route.controller
}

pub fn (route Route) get_function_name() string {
	return route.function
}

pub fn (route Route) get_controller_instance() T {
	return route.controller
}
