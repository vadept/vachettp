module vachettp_response

struct TestCase {
	response Response
	expect []byte
}

fn test_format() {
	test_cases := [
		TestCase{Response{'HTTP/1.1', 200, map[string]string{}, ''}, 'HTTP/1.1 200 OK'.bytes()}
		TestCase{Response{'HTTP/2', 200, {'Content-Type': 'text/plain'}, ''}, 'HTTP/2 200 OK\r\nContent-Type: text/plain'.bytes()}
		TestCase{Response{'HTTP/2', 200, {'Content-Type': 'text/plain', 'Content-Length': '0'}, ''}, 'HTTP/2 200 OK\r\nContent-Type: text/plain'.bytes()}
		TestCase{Response{'HTTP/2', 200, {'Content-Type': 'text/plain', 'Content-Length': '5'}, 'hello'}, 'HTTP/2 200 OK\r\nContent-Type: text/plain\r\nContent-Length: 5\r\n\r\nhello'.bytes()}
	]

	for test_case in test_cases {
		assert test_case.expect == test_case.response.format()
	}
}
