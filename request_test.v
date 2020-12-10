import vachettp

fn test_get_method() {
	rp := vachettp.RequestParser{command : 'GET /toto HTTP/1.1'}
	r := rp.parse()

	assert r.get_method() == 'GET'
}

fn test_get_path() {
	rp := vachettp.RequestParser{command : 'GET /toto HTTP/1.1'}
	r := rp.parse()

	assert r.get_path() == '/toto'
}

fn test_get_protocol_version() {
	rp := vachettp.RequestParser{command : 'GET /toto HTTP/1.1'}
	r := rp.parse()

	assert r.get_protocol_version() == 'HTTP/1.1'
}
