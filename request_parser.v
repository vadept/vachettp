module vachettp

pub struct RequestParser {
	command string
}

pub fn (requestParser RequestParser) parse() Request {
	elements := requestParser.command.split(' ')
	return Request{
		method : elements[0]
		path : elements[1]
		protocol_version : elements[2]
	}
}

fn check_method(method string)
