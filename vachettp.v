module vachettp

import net
import time

pub struct Server {
	port int
}

pub fn (server Server) run() {
	println('[Vachettp] Starting server...')
	listener := net.listen_tcp(server.port) or { panic('[Vachettp] Failed to listen to port "$server.port".') }
	println('[Vachettp] Server listening on port "$server.port"')

	for {
		mut connection := listener.accept() or { panic('[Vachettp] Failed to accept a new request.') }
		handle_connection(mut connection)
	}
}

fn handle_connection(mut connection net.TcpConn) {
	connection.set_read_timeout(1 * time.second)
	defer { connection.close() or {} }

	handle_connection_response(
		connection, 
		'HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\nContent-Length: 13\r\n\r\nHello, World!'
	)
}

/**
* Handle the response from server
**/
fn handle_connection_response(connection net.TcpConn, response string) {
	connection.write(response.bytes())
}
