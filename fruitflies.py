import os
import time
import socket
import argparse
import sys
import subprocess
from http.server import SimpleHTTPRequestHandler, HTTPServer

def health_check():
    # Simulate a health check function
    print("Health check passed")
    sys.stdout.flush()

def is_port_open(port):
    try:
        # Check if the port is open by attempting to connect to it
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
            sock.settimeout(1)
            result = sock.connect_ex(('localhost', port))
            if result == 0:
                print(f"Port {port} is open")
                sys.stdout.flush()
                return True
            else:
                print(f"Port {port} is abruptly dropped")
                sys.stdout.flush()
                return False
    except Exception as e:
        print(f"Error checking port {port}: {e}")
        sys.stdout.flush()
        return False

def run_server(port):
    server_address = ('', port)
    httpd = HTTPServer(server_address, SimpleHTTPRequestHandler)
    print(f"Starting HTTP server on port {port}")
    sys.stdout.flush()
    httpd.serve_forever()

def main(port):
    try:
        print(f"Monitoring port {port}")
        sys.stdout.flush()

        # Start the HTTP server in a separate thread
        import threading
        server_thread = threading.Thread(target=run_server, args=(port,))
        server_thread.daemon = True
        server_thread.start()

        # Wait for the server to start
        time.sleep(1)

        while True:
            health_check()
            time.sleep(1)
    except Exception as e:
        print(f"An error occurred: {e}")
        sys.stdout.flush()
    finally:
        print("Exiting application")
        sys.stdout.flush()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Monitor a port.')
    parser.add_argument('--port', type=int, default=int(os.getenv('PORT', 80)), help='Port to monitor')
    args = parser.parse_args()
    main(args.port)