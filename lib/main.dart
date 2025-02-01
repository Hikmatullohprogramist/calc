import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String number1 = "";
  String operand = "";
  String number2 = "";

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        bottom: true,
        child: Column(
          children: [
            // Output Display
            Expanded(
              child: Container(
                width: screenSize.width,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${number1}${operand}${number2}",
                      style: Theme.of(context).textTheme.displaySmall,
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
            ),
            // Keypad
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildButton("7"),
                      _buildButton("8"),
                      _buildButton("9"),
                      _buildButton("÷"),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildButton("4"),
                      _buildButton("5"),
                      _buildButton("6"),
                      _buildButton("×"),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildButton("1"),
                      _buildButton("2"),
                      _buildButton("3"),
                      _buildButton("-"),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildButton("C"),
                      _buildButton("0"),
                      _buildButton("="),
                      _buildButton("+"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ElevatedButton(
          onPressed: () => _handleButtonPress(text),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  void _handleButtonPress(String text) {
    setState(() {
      if (text == "C") {
        number1 = "";
        operand = "";
        number2 = "";
      } else if (text == "=") {
        if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
          final result = _calculate();
          number1 = result;
          operand = "";
          number2 = "";
        }
      } else if (_isOperator(text)) {
        if (number1.isNotEmpty && number2.isNotEmpty) {
          final result = _calculate();
          number1 = result;
          number2 = "";
        }
        if (number1.isNotEmpty) {
          operand = text;
        }
      } else {
        if (operand.isEmpty) {
          number1 += text;
        } else {
          number2 += text;
        }
      }
    });
  }

  bool _isOperator(String text) {
    return text == "+" || text == "-" || text == "×" || text == "÷";
  }

  String _calculate() {
    if (number1.isEmpty || operand.isEmpty || number2.isEmpty) return "";

    final num1 = double.parse(number1);
    final num2 = double.parse(number2);
    double result = 0;

    switch (operand) {
      case "+":
        result = num1 + num2;
        break;
      case "-":
        result = num1 - num2;
        break;
      case "×":
        result = num1 * num2;
        break;
      case "÷":
        if (num2 != 0) {
          result = num1 / num2;
        } else {
          return "Error";
        }
        break;
    }

    if (result == result.toInt()) {
      return result.toInt().toString();
    }
    return result.toString();
  }
}
