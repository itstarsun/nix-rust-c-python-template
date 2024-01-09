import unittest

import example


class TestHello(unittest.TestCase):
    def test_hello(self) -> None:
        self.assertEqual(example.hello(), "Hello from Rust!")


if __name__ == "__main__":
    unittest.main()
