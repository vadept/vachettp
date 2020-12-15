module vachettp

pub struct RequestParser {
	command []byte
}

pub fn (requestParser RequestParser) parse() Request {
	command_content := requestParser.command.bytestr()
	lines := command_content.split('\r\n')
	first_line := lines[0]
	first_line_elements := first_line.split(' ')
	
	if first_line_elements.len != 3 {
		return Request{}
	}
	
	method := set_method(first_line_elements[0])
	path := set_path(first_line_elements[1])
	protocol_version := set_protocol_version(first_line_elements[2])
	query_params := set_query_params(first_line_elements[1])

	mut headers := set_headers(lines[1..])

	return Request{method, path, protocol_version, headers, query_params, ''}
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
