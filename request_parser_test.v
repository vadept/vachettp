import vachettp

fn test_parse_command() {
	rp := vachettp.RequestParser{command : 'GET /toto HTTP/1.1'}
	r := rp.parse()

	assert 'GET' == r.get_method()
}
