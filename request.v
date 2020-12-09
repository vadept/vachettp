module vachettp

pub struct Request {
	method string
	path string
	protocol_version string
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
