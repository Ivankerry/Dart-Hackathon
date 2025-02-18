double calculate(String expression) {
  // Remove any whitespace from the expression
  expression = expression.replaceAll(' ', '');

  // Handle multi-step calculations using a stack-based approach
  List<double> operands = [];
  List<String> operators = [];

  for (int i = 0; i < expression.length; i++) {
    String char = expression[i];

    if (char == '(') {
      operators.add(char);
    } else if (char == ')') {
      while (operators.isNotEmpty && operators.last != '(') {
        _performOperation(operands, operators);
      }
      operators.removeLast(); // Remove the '('
    } else if (char == '+' || char == '-' || char == '*' || char == '/') {
      while (operators.isNotEmpty &&
          _precedence(char) <= _precedence(operators.last)) {
        _performOperation(operands, operators);
      }
      operators.add(char);
    } else {
      // Handle numbers (including multi-digit numbers)
      String number = char;
      while (i + 1 < expression.length &&
          '0123456789.'.contains(expression[i + 1])) {
        number += expression[i + 1];
        i++;
      }
      operands.add(double.parse(number));
    }
  }

  while (operators.isNotEmpty) {
    _performOperation(operands, operators);
  }

  if (operands.length != 1) {
    throw FormatException('Invalid expression');
  }

  return operands.last;
}

void _performOperation(List<double> operands, List<String> operators) {
  if (operands.length < 2 || operators.isEmpty) {
    throw FormatException('Invalid expression');
  }

  double operand2 = operands.removeLast();
  double operand1 = operands.removeLast();
  String operator = operators.removeLast();

  switch (operator) {
    case '+':
      operands.add(operand1 + operand2);
      break;
    case '-':
      operands.add(operand1 - operand2);
      break;
    case '*':
      operands.add(operand1 * operand2);
      break;
    case '/':
      if (operand2 == 0) {
        throw ZeroDivisionError();
      }
      operands.add(operand1 / operand2);
      break;
    default:
      throw FormatException('Invalid operator: $operator');
  }
}

int _precedence(String operator) {
  switch (operator) {
    case '+':
    case '-':
      return 1;
    case '*':
    case '/':
      return 2;
    default:
      return 0;
  }
}
