module vachettp

pub struct Router {
	routes []Route
}

pub fn (router Router) get_route_by_path (path string) ?Route {
	for route in router.routes {
		if route.get_path() == path {
			return route
		}
	}

	return error()
}
