
import 'package:flutter_test/flutter_test.dart';
import 'package:rpn_calculator/main.dart';

void main() {
  test('Polish Notation Evaluation', () {
    CalculatorState calculator = CalculatorState();

    double result1 = calculator.calculateResult(['5', '3', '+']);
    expect(result1, 8.0);

    double result2 = calculator.calculateResult(['5', '3', '-']);
    expect(result2, 2.0);

    double result3 = calculator.calculateResult(['2', '3', '*']);
    expect(result3, 6.0);

    double result4 = calculator.calculateResult(['6', '2', '/']);
    expect(result4, 3.0);

    double result5 = calculator.calculateResult(['5', '3', '+']);
    expect(result5, 8.0);

    double result6 = calculator.calculateResult(['10', '4', '3', '*', '+', '2', '/']);
    expect(result6, 11.0);

  });
}