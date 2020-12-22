module vachettp_router

pub struct Route<T> {
	path string
	function string
}

pub fn create_route<T>(path string, function string) Route<T> {
	return Route<T>{path, function}
}

// pub fn (route Route<T>) get_path() string {
// 	return route.path
// }

// pub fn (route Route<T>) get_controller_type() string {
// 	return T.name
// }

// pub fn (route Route<T>) get_function_name() string {
// 	return route.function
// }
