import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = '';
  List<String> _stack = [];
  String number = '';

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'Enter') {
        try {
          if (number.isNotEmpty) {
            _stack.add(number);
            number = '';
          }
          double result = evaluatePolishNotation(_stack);
          _output = result.toString();
          _stack.clear();
        } catch (e) {
          _output = 'Error';
        }
      } else if (value == 'C') {
        _output = '';
        _stack.clear();
        number = '';
      } else if (value == 'Space') {
        if (number.isNotEmpty) {
          _stack.add(number);
          number = '';
        }
        _output = _stack.join(' ');
      } else {
        number += value;
        _output = _stack.join(' ') + ' ' + number;
      }
    });
  }



  double evaluatePolishNotation(List<String> tokens) {
    List<double> stack = [];
    for (String token in tokens) {
      if (isNumeric(token)) {
        stack.add(double.parse(token));
      } else {
        double operand2 = stack.removeLast();
        double operand1 = stack.removeLast();
        double result = performOperation(token, operand1, operand2);
        stack.add(result);
      }
    }
    return stack.single;
  }

  bool isNumeric(String value) {
    return double.tryParse(value) != null;
  }

  double performOperation(String operator, double operand1, double operand2) {
    switch (operator) {
      case '+':
        return operand1 + operand2;
      case '-':
        return operand1 - operand2;
      case '*':
        return operand1 * operand2;
      case '/':
        if (operand2 != 0) {
          return operand1 / operand2;
        } else {
          throw Exception('Cant divide by zero');
        }
      default:
        throw Exception('Cant use operator: $operator');
    }
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () {
            _onButtonPressed(buttonText);
          },
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20.0),
              child: Text(
                _output,
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
          Divider(
            height: 1.0,
            color: Colors.black,
          ),
          Column(
            children: [
              Row(
                children: [
                  _buildButton('Space'),
                ],
              ),
              Row(
                children: [
                  _buildButton('7'),
                  _buildButton('8'),
                  _buildButton('9'),
                  _buildButton('/'),
                ],
              ),
              Row(
                children: [
                  _buildButton('4'),
                  _buildButton('5'),
                  _buildButton('6'),
                  _buildButton('*'),
                ],
              ),
              Row(
                children: [
                  _buildButton('1'),
                  _buildButton('2'),
                  _buildButton('3'),
                  _buildButton('-'),
                ],
              ),
              Row(
                children: [
                  _buildButton('0'),
                  _buildButton('C'),
                  _buildButton('Enter'),
                  _buildButton('+'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
