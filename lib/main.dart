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
      title: 'حاسبة بسيطة',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _input = "";
  double _num1 = 0;
  double _num2 = 0;
  String _operand = "";

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _input = "";
        _num1 = 0;
        _num2 = 0;
        _operand = "";
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "×" || buttonText == "÷") {
        _num1 = double.tryParse(_output) ?? 0;
        _operand = buttonText;
        _input = "";
      } else if (buttonText == "=") {
        _num2 = double.tryParse(_output) ?? 0;
        if (_operand == "+") {
          _output = (_num1 + _num2).toString();
        } else if (_operand == "-") {
          _output = (_num1 - _num2).toString();
        } else if (_operand == "×") {
          _output = (_num1 * _num2).toString();
        } else if (_operand == "÷") {
          _output = _num2 != 0 ? (_num1 / _num2).toString() : "خطأ";
        }
        _operand = "";
        _input = "";
      } else {
        if (_output == "0" || _input == "") {
          _output = buttonText;
        } else {
          _output += buttonText;
        }
        _input = _output;
      }
      
      // إزالة الصفر الزائد للأعداد العشرية إذا كانت صحيحة
      if (_output.endsWith(".0")) {
        _output = _output.substring(0, _output.length - 2);
      }
    });
  }

  Widget _buildButton(String buttonText, Color color, Color textColor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: textColor,
            padding: const EdgeInsets.all(24.0),
            textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () => _buttonPressed(buttonText),
          child: Text(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حاسبة Flutter'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Text(
                _output,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Divider(height: 1),
          Column(
            children: [
              Row(children: [
                _buildButton("7", Colors.grey[200]!, Colors.black),
                _buildButton("8", Colors.grey[200]!, Colors.black),
                _buildButton("9", Colors.grey[200]!, Colors.black),
                _buildButton("÷", Colors.orange, Colors.white),
              ]),
              Row(children: [
                _buildButton("4", Colors.grey[200]!, Colors.black),
                _buildButton("5", Colors.grey[200]!, Colors.black),
                _buildButton("6", Colors.grey[200]!, Colors.black),
                _buildButton("×", Colors.orange, Colors.white),
              ]),
              Row(children: [
                _buildButton("1", Colors.grey[200]!, Colors.black),
                _buildButton("2", Colors.grey[200]!, Colors.black),
                _buildButton("3", Colors.grey[200]!, Colors.black),
                _buildButton("-", Colors.orange, Colors.white),
              ]),
              Row(children: [
                _buildButton("C", Colors.red[400]!, Colors.white),
                _buildButton("0", Colors.grey[200]!, Colors.black),
                _buildButton("=", Colors.green, Colors.white),
                _buildButton("+", Colors.orange, Colors.white),
              ]),
            ],
          )
        ],
      ),
    );
  }
}
