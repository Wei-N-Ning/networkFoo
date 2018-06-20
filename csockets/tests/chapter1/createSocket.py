
import os
import shlex
import socket
import subprocess
import unittest


class Test(unittest.TestCase):

    def test_create_socket(self):
        sender, receiver = socket.socketpair(socket.AF_UNIX, socket.SOCK_STREAM, proto=0)
        data = b'dude'
        sender.send(data)
        self.assertEqual(data, receiver.recv(9))
        sender.close()
        receiver.close()

    def test_compare_sockets_to_pipes(self):
        data = b'dude'
        r_fd, w_fd = os.pipe()
        os.write(w_fd, data)
        self.assertEqual(data, os.read(r_fd, 9))
        os.close(r_fd)
        os.close(w_fd)


if __name__ == '__main__':
    unittest.main()
