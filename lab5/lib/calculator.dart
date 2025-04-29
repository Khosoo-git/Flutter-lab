import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

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
    return GridView.builder(
      padding: EdgeInsets.all(8),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 2.8,
      ),
      itemCount: buttons.length,
      itemBuilder: (context, index) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(16),
            backgroundColor:
                buttons[index] == '=' ? Colors.white : Colors.white,
            foregroundColor:
                buttons[index] == '=' ? Colors.black : Colors.black,
          ),
          onPressed: () => _onButtonPressed(buttons[index]),
          child: Text(buttons[index], style: TextStyle(fontSize: 22)),
        );
      },
    );
  }
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
