module vachettp_request

fn test_get_method() {
	rp := RequestParser{'GET /foo HTTP/1.1'}
	r := rp.parse()

	assert r.get_method() == 'GET'
}

fn test_get_path() {
	rp := RequestParser{'GET /foo HTTP/1.1'}
	r := rp.parse()

	assert r.get_path() == '/foo'
}

fn test_get_protocol_version() {
	rp := RequestParser{'GET /foo HTTP/1.1'}
	r := rp.parse()

	assert r.get_protocol_version() == 'HTTP/1.1'
}

fn test_get_headers() {
	rp := RequestParser{'GET /foo HTTP/1.1\r\nContent-Type: application/json'}
	r := rp.parse()

	assert r.get_headers() == {'Content-Type': 'application/json'}
}

fn test_get_query_params() {
	rp := RequestParser{'GET /foo?field1=bar&field2=bazz&field3=buzz HTTP/2\r\nContent-Type: application/json\r\nAuthorization: Bearer 1337'}
	r := rp.parse()

	assert r.get_query_params() == {'field1': 'bar', 'field2': 'bazz', 'field3': 'buzz'}
}
