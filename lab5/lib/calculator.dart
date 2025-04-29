import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

List<String> buttons = [
  '7',
  '8',
  '9',
  '÷',
  '4',
  '5',
  '6',
  '×',
  '1',
  '2',
  '3',
  '-',
  '.',
  '0',
  '00',
  '+',
  'CLEAR',
  '=',
];

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  String result = '0';
  List<Map<String, String>> history = [];

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'CLEAR') {
        input = '';
        result = '0';
      } else if (value == '=') {
        if (input.isNotEmpty) {
          try {
            result = _evaluateExpression(input);
            history.add({'expression': input, 'result': result});
            input = result;
          } catch (e) {
            result = 'Error';
          }
        }
      } else {
        if (value == '.') {
          if (input.isNotEmpty && input[input.length - 1] == '.') {
            return;
          }
          int lastOperatorIndex = input.lastIndexOf(RegExp(r'[+\-×÷]'));
          String lastNumber =
              (lastOperatorIndex != -1)
                  ? input.substring(lastOperatorIndex + 1)
                  : input;
          if (lastNumber.contains('.')) {
            return;
          }
        }

        if (value == '0') {
          if (input == '0') {
            return;
          }
          int lastOperatorIndex = input.lastIndexOf(RegExp(r'[+\-×÷]'));
          if (lastOperatorIndex == input.length - 1) {
            input += '0'; // зөв
            return;
          }
        }

        input += value;
      }
    });
  }

  String _evaluateExpression(String expression) {
    try {
      expression = expression.replaceAll('×', '*').replaceAll('÷', '/');
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      return eval.toStringAsFixed(2).replaceAll('.00', '');
    } catch (e) {
      return 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            tooltip: 'View History',
            onPressed: () {
              Navigator.pushNamed(context, '/history', arguments: history);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: TextStyle(fontSize: 28, color: Colors.grey),
                  ),
                  Text(
                    result,
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Expanded(flex: 3, child: _buildButtonGrid()),
        ],
      ),
    );
  }

  Widget _buildButtonGrid() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children:
            buttons.map((button) {
              double widthFactor = (button == 'CLEAR' || button == '=') ? 2 : 1;

              return SizedBox(
                width:
                    (MediaQuery.of(context).size.width - 48) / 4 * widthFactor,
                height: 60,
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  child: InkWell(
                    onTap: () => _onButtonPressed(button),
                    borderRadius: BorderRadius.circular(4),
                    splashColor: Colors.grey.withOpacity(0.3),
                    highlightColor: Colors.grey.withOpacity(0.2),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        button,
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
