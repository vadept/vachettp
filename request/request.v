module vachettp_request

pub struct Request {
	method string
	path string
	protocol_version string
	headers map[string]string
	query_params map[string]string
}

pub fn (request Request) get_method() string {
	return request.method
}

pub fn (request Request) get_path() string {
	return request.path
}

pub fn (request Request) get_protocol_version() string {
	return request.protocol_version
}

pub fn (request Request) get_headers() map[string]string {
	return request.headers
}

pub fn (request Request) get_query_params() map[string]string {
	return request.query_params
}
