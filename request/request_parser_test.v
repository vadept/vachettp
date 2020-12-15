module vachettp_request

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
		rp := RequestParser{test_case.given}
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
		rp := RequestParser{test_case.given}
		r := rp.parse()

		assert test_case.expect == r.get_protocol_version()
	}
}

fn test_path_parsing() {
	test_cases := [
		TestCase{'GET /foo HTTP/2', '/foo'},
		TestCase{'GET foo HTTP/2', ''},
	]

	for test_case in test_cases {
		rp := RequestParser{test_case.given}
		r := rp.parse()

		assert test_case.expect == r.get_path()
	}
}

struct RequestTestCase {
	given string
	expect Request
}

fn test_command_first_line() {
	test_cases := [
		RequestTestCase{'', Request{}},
		RequestTestCase{'GET', Request{}},
		RequestTestCase{'GET /', Request{}},
		RequestTestCase{'GET HTTP/2', Request{}},
		RequestTestCase{'GET / HTTP/2', Request{'GET', '/', 'HTTP/2', map[string]string{}, map[string]string{}}},
		RequestTestCase{'GET / HTTP/2 foo', Request{}},
	]

	for test_case in test_cases {
		rp := RequestParser{test_case.given}
		r := rp.parse()

		assert r.get_method() == test_case.expect.get_method()
		assert r.get_path() == test_case.expect.get_path()
		assert r.get_protocol_version() == test_case.expect.get_protocol_version()
	}
}

fn test_multiline() {
	test_cases := [
		RequestTestCase{'GET /foo HTTP/2\r\nContent-Type: application/json', Request{'GET', '/foo', 'HTTP/2', {'Content-Type': 'application/json'}, map[string]string{}}},
		RequestTestCase{'GET /foo HTTP/2\r\nContent-Type: application/json\r\nAuthorization: Bearer 1337', Request{'GET', '/foo', 'HTTP/2', {'Content-Type': 'application/json', 'Authorization': 'Bearer 1337'}, map[string]string{}}},
	]

	for test_case in test_cases {
		rp := RequestParser{test_case.given}
		r := rp.parse()

		assert r.get_method() == test_case.expect.get_method()
		assert r.get_path() == test_case.expect.get_path()
		assert r.get_protocol_version() == test_case.expect.get_protocol_version()
		assert r.get_headers() == test_case.expect.get_headers()
	}
}

fn test_query_params() {
	test_cases := [
		RequestTestCase{'GET /foo HTTP/2\r\nContent-Type: application/json', Request{'GET', '/foo', 'HTTP/2', {'Content-Type': 'application/json'}, map[string]string{}}},
		RequestTestCase{'GET /foo?field1=foo HTTP/2\r\nContent-Type: application/json', Request{'GET', '/foo', 'HTTP/2', {'Content-Type': 'application/json'}, {'field1': 'foo'}}},
		RequestTestCase{
			'GET /foo?field1=foo&field2=bar&field3=bazz HTTP/2\r\nContent-Type: application/json', 
			Request{
				'GET', 
				'/foo', 
				'HTTP/2', 
				{'Content-Type': 'application/json'}, 
				{'field1': 'foo', 'field2': 'bar', 'field3': 'bazz'}
			}
		},
		RequestTestCase{
			'GET /foo?field1=foo&field2&field3=bazzfield4=buzz HTTP/2\r\nContent-Type: application/json', 
			Request{
				'GET', 
				'/foo', 
				'HTTP/2', 
				{'Content-Type': 'application/json'}, 
				{'field1': 'foo'}
			}
		},
		RequestTestCase{
			'GET /foo?field1=foo&field2=barfield3=bazz HTTP/2\r\nContent-Type: application/json', 
			Request{
				'GET', 
				'/foo', 
				'HTTP/2', 
				{'Content-Type': 'application/json'}, 
				{'field1': 'foo'}
			}
		},
	]

	for test_case in test_cases {
		rp := RequestParser{test_case.given}
		r := rp.parse()

		assert r.get_path() == test_case.expect.get_path()
		assert r.get_query_params() == test_case.expect.get_query_params()
	}
}
