import 'dart:math';

List<String> shuntingYard(String infix) {
  List output = [];
  List operatorStack = [];
  Map<String, Map<String, num>> operators = {
    "^": {"precedence": 4, "associativity": 1},
    "*": {"precedence": 3, "associativity": 0},
    "/": {"precedence": 3, "associativity": 0},
    "+": {"precedence": 2, "associativity": 0},
    "-": {"precedence": 2, "associativity": 0}
  };

  List<String> tempInfixList = infix.split(RegExp(r'\s+'));
  List infixList = [];
  for (int i = 0; i < tempInfixList.length; i++) {
    if (tempInfixList[i].contains('(') || tempInfixList[i].contains(')')) {
      infixList.addAll(tempInfixList[i].split(''));
    } else {
      infixList.add(tempInfixList[i]);
    }
  }

  for (int i = 0; i < infixList.length; i++) {
    String token = infixList[i];
    if (token == "(") {
      operatorStack.add(token);
    } else if (token == ")") {
      while (operatorStack[operatorStack.length - 1] != "(") {
        output.add(operatorStack.removeLast());
      }
      operatorStack.removeLast();
    } else if (RegExp(r"[\+\-\*\/\^]").hasMatch(token)) {
      String o1 = token;
      String o2 = operatorStack.isNotEmpty ? operatorStack.last : "";
      while ((RegExp(r"[\+\-\*\/\^]").hasMatch(o2)) &&
          ((operators[o1]?["associativity"] == 0 &&
                  operators[o1]!["precedence"]! <=
                      operators[o2]!["precedence"]!) ||
              (operators[o1]?["associativity"] == 1 &&
                  operators[o1]!["precedence"]! <
                      operators[o2]!["precedence"]!))) {
        output.add(operatorStack.removeLast());
        o2 = operatorStack.isNotEmpty ? operatorStack.last : "";
      }
      operatorStack.add(o1);
    } else {
      output.add(token);
    }
  }
  while (operatorStack.isNotEmpty) {
    output.add(operatorStack.removeLast());
  }
  return List.from(output);
}

String calculateRPN(String expression) {
  List<String> expressionStack = shuntingYard(expression);
  var resultStack = [];
  for (int i = 0; i < expressionStack.length; i++) {
    String token = expressionStack[i];

    if (RegExp(r"[\+\-\*\/\^]").hasMatch(token) == false) {
      resultStack.add(double.parse(token));
    } else {
      print(resultStack);
      var rhs = resultStack.removeLast();
      var lhs = resultStack.isNotEmpty ? resultStack.removeLast() : 0;
      switch (token) {
        case ('+'):
          resultStack.add(lhs + rhs);
          break;
        case ('-'):
          resultStack.add(lhs - rhs);
          break;
        case ('*'):
          resultStack.add(lhs * rhs);
          break;
        case ('/'):
          resultStack.add(lhs / rhs);
          break;
        case ('^'):
          print(12);
          if (i < expressionStack.length - 1) {
            if (expressionStack[i + 1] == '^') {
              resultStack.add(lhs * rhs);
            } else {
              resultStack.add(pow(lhs, rhs));
            }
          } else {
            resultStack.add(pow(lhs, rhs));
          }

          break;
        default:
          break;
      }
    }
  }
  return resultStack.removeLast().toString();
}

void main() {
  print(calculateRPN(" - 1 ^ 2"));
}
