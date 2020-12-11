module vachettp

pub struct RequestParser {
	command string
}

pub fn (requestParser RequestParser) parse() Request {
	elements := requestParser.command.split(' ')

	if elements.len != 3 {
		return Request{}
	}

	return Request{
		method : set_method(elements[0])// or { return error(err) }
		path : set_path(elements[1])
		protocol_version : set_protocol_version(elements[2])
	}
}

fn set_method(method string) string {
	if method in ['GET', 'HEAD', 'POST', 'OPTIONS', 'TRACE', 'PUT', 'PATCH', 'DELETE'] {
		return method
	}

	// TODO: handle error
	// return error('Request has wrong method.')
	println('Request has wrong method.')
	return ''
}

fn set_protocol_version(protocol_version string) string {
	pv := protocol_version.split('/')

	if 2 != pv.len {
		// TODO: handle error
		// return error('Request has wrong protocol version format.')
		println('Request has wrong protocol version format.')
		return ''
	}

	if pv[0] in ['HTTP', 'http'] && pv[1] in ['1.0', '1.1', '2'] {
		return protocol_version
	}

	// TODO: handle error
	// return error('Request has wrong protocol version or protocol version is not supported.')
	println('Request has wrong protocol version or protocol version is not supported.')
	return ''
}

fn set_path(path string) string {
	if path[0] == `/` {
		return path
	}

	// TODO: handle error
	// return error('Request has wrong path format.')
	println('Request has wrong path format.')
	return ''
}
