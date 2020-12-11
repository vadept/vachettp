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

fn test_protocol_version_parsing() {
	test_cases := [
		TestCase{'GET /foo HTTP/1.0', 'HTTP/1.0'},
		TestCase{'GET /foo http/1.0', 'http/1.0'},
		TestCase{'GET /foo HTTP/1.1', 'HTTP/1.1'},
		TestCase{'GET /foo http/1.1', 'http/1.1'},
		TestCase{'GET /foo HTTP/2', 'HTTP/2'},
		TestCase{'GET /foo http/2', 'http/2'},
		TestCase{'GET /foo HTTP2', ''},
		TestCase{'GET /foo HTTP/3', ''},
	]

	for test_case in test_cases {
		r := vachettp.RequestParser{test_case.given}.parse()

		assert test_case.expect == r.get_protocol_version()
	}
}
