module vachettp_request

pub struct RequestParser {
	command string
}

pub fn (requestParser RequestParser) parse() Request {
	lines := requestParser.command.split('\r\n')

	if 0 == lines.len {
		return Request{}
	}

	elements := lines[0].split(' ')

	if elements.len != 3 {
		return Request{}
	}

	return Request{
		method : set_method(elements[0])// or { return error(err) }
		path : set_path(elements[1])
		protocol_version : set_protocol_version(elements[2])
		headers : set_headers(lines[1..])
		query_params : set_query_params(elements[1])
	}
}

fn set_method(method string) string {
	if method in get_http_verbs() {
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

	if pv[0] in ['HTTP', 'http'] && pv[1] in get_http_version() {
		return protocol_version
	}

	// TODO: handle error
	// return error('Request has wrong protocol version or protocol version is not supported.')
	println('Request has wrong protocol version or protocol version is not supported.')
	return ''
}

fn set_path(path string) string {
	splitted_path := path.split('?')
	if splitted_path[0][0] == `/` {
		return splitted_path[0]
	}

	// TODO: handle error
	// return error('Request has wrong path format.')
	println('Request has wrong path format.')
	return ''
}

fn set_headers(lines []string) map[string]string {
	mut headers := map[string]string
	for line in lines {
		elements := line.split(':')
		if 2 == elements.len {
			headers[elements[0].trim(' ')] = elements[1].trim(' ')
		}
	}

	return headers
}

fn set_query_params(path string) map[string]string {
	path_parts := path.split('?')
	if 2 != path_parts.len {
		return map[string]string{}
	}
	mut query_params := map[string]string
	query_elements := path_parts[1].split('&')
	for query_element in query_elements {
		query_parts := query_element.split('=')
		if 2 == query_parts.len {
			query_params[query_parts[0]] = query_parts[1]
		}
	}

	return query_params
}

fn get_http_verbs() []string {
	return ['GET', 'HEAD', 'POST', 'OPTIONS', 'TRACE', 'PUT', 'PATCH', 'DELETE']
}

fn get_http_version() []string {
	return ['1.0', '1.1', '2']
}
