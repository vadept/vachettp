module vachettp

pub struct RequestParser {
	command string
}

pub fn (requestParser RequestParser) parse() Request {
	elements := requestParser.command.split(' ')
	return Request{
		method : set_method(elements[0])// or { return error(err) }
		path : elements[1]
		protocol_version : elements[2]
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
