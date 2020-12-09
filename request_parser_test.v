import vachettp

struct TestCase {
	given string
	expect string
}

fn test_method_parsing() {
	test_cases := [
		TestCase{'GET /foo HTTP/1.1', 'GET'},
		TestCase{'POST /foo HTTP/1.1', 'POST'},
		TestCase{'HEAD /foo HTTP/1.1', 'HEAD'},
		TestCase{'OPTIONS /foo HTTP/1.1', 'OPTIONS'},
		TestCase{'TRACE /foo HTTP/1.1', 'TRACE'},
		TestCase{'PUT /foo HTTP/1.1', 'PUT'},
		TestCase{'PATCH /foo HTTP/1.1', 'PATCH'},
		TestCase{'DELETE /foo HTTP/1.1', 'DELETE'},
		TestCase{'FOO /foo HTTP/1.1', ''},
	]

	for test_case in test_cases {
		rp := vachettp.RequestParser{command : test_case.given}
		r := rp.parse()

		assert test_case.expect == r.get_method()
	}
}

// fn test_parse_command() {
// 	rp := vachettp.RequestParser{command : 'GET /foo HTTP/1.1'}
// 	r := rp.parse() or { vachettp.Request{} }

// 	assert 'GET' == r.get_method()
// }
