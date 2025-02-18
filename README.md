# Dart-Hackathon

# Dart Calculator Function

This Dart function performs basic arithmetic operations on two numbers, with support for multi-step calculations, parentheses, and error handling for division by zero and invalid expressions.

## Features

*   Supports basic arithmetic operations: addition (+), subtraction (-), multiplication (*), and division (/).
*   Handles multi-step calculations using a stack-based approach, respecting the order of operations (PEMDAS/BODMAS).
*   Supports parentheses to control the order of operations.
*   Handles division by zero errors by throwing a `ZeroDivisionError`.
*   Handles invalid expressions by throwing a `FormatException`.
*   Supports multi-digit numbers and decimal values.
*   Ignores whitespace in the input expression.

## Usage

```dart
double calculate(String expression);

##Example

import 'package:your_package_name/calculator.dart'; // Replace with your package name

void main() {
  try {
    double result1 = calculate("2 + 3 * (4 - 1)");
    print("Result 1: $result1"); // Output: Result 1: 11.0

    double result2 = calculate("5 / 0"); // Division by zero
    print("Result 2: $result2");
  } catch (e) {
    print("Error: $e"); // Output: Error: ZeroDivisionError
  }

  try {
    double result3 = calculate("2 + invalid"); // Invalid expression
    print("Result 3: $result3");
  } catch (e) {
    print("Error: $e"); // Output: Error: FormatException: Invalid expression
  }

  try {
    double result4 = calculate("10.5 * 2 + 5");
    print("Result 4: $result4"); // Output: Result 4: 26.0
  } catch (e) {
    print("Error: $e");
  }
}


##Installation

dependencies:
  your_package_name: ^1.0.0 # Replace with the correct version

Run flutter pub get or dart pub get in your terminal.
Error Handling
The calculate function throws the following exceptions:
 * ZeroDivisionError: If division by zero is attempted.
 * FormatException: If the input expression is invalid (e.g., missing operands, invalid operators, unmatched parentheses).
Contributing
Contributions are welcome! Please open an issue or submit a pull request.
License
[Choose a license - e.g., MIT License]
Note: Replace your_package_name with the actual name of your package.  Also, make sure to create a calculator.dart file (or whatever you name your Dart file) in your project's lib directory containing the code provided earlier.  This README assumes you've packaged this as a Dart package. If it's just a script, adjust the installation and import instructions as needed.

This README provides a comprehensive overview of the calculator function, including its features, usage, installation instructions, error handling, and contribution guidelines.  Remember to choose a license and replace the placeholder text.  If you're not creating a package, you can simplify the installation instructions


# Dart Palindrome Checker

This Dart function checks if a given string or number is a palindrome, ignoring spaces, punctuation, and case sensitivity.

## Features

*   Handles both strings and integers as input.
*   Case-insensitive palindrome check.
*   Ignores spaces and punctuation.
*   Efficient two-pointer algorithm for palindrome checking.
*   Includes error handling for invalid input types.

## Usage

```dart
bool isPalindrome(dynamic input);
