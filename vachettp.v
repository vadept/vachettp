module vachettp

import io
import net
import time

pub fn run_app() {
	l := net.listen_tcp(8080) or { panic('failed to listen') }
	println('Starting Vachettp on 8080...')
	for {
		mut conn := l.accept() or { panic('accept() failed') }
		handle_connection_request(mut conn)
	}
}

fn handle_connection_request(mut conn net.TcpConn) {
	conn.set_read_timeout(1 * time.second)
	defer { conn.close() or {} }

	mut reader := io.new_buffered_reader(reader: io.make_reader(conn))
	
	mut command := io.read_all(reader) or { []byte{} }

	rp := RequestParser{command}
	r := rp.parse()

	println(r)

	handle_connection_response(conn, 'HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\nContent-Length: 13\r\n\r\nHello, World!')
}

fn handle_connection_response(conn net.TcpConn, s string) {
	conn.write(s.bytes())
}
