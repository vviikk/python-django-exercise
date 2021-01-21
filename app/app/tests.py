from django.test import TestCase

from app.calc import add, subtract


class CalcTests(TestCase):
    def test_add_numbers(self):
        """Test that two numbers are added"""
        self.assertEqual(add(3, 8), 11)

    def test_subtract_numbers(self):
        """Test that one number from another"""
        self.assertEqual(subtract(1, 5), 4)
