import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(Calculator());

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  void buttonPressed(String text) {
    print(text);
    setState(() {
      if (text == "AC") {
        equation = "0";
        result = "0";
      } else if (text == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (text == "=") {
        expression = equation;
        expression = expression.replaceAll("×", "*");
        expression = expression.replaceAll("÷", "/");
        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (error) {}
      } else {
        if (equation == "0") {
          equation = text;
        } else {
          equation += text;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
        .copyWith(systemNavigationBarColor: Colors.orange));
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.orange),
        home: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            elevation: 0,
            title: Text(
              "Calculator",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          body: SafeArea(
            child: Container(
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                    child: Text(equation,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 100),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: Text(result,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        )),
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  Column(
                    children: [
                      Table(
                        children: [
                          TableRow(children: [
                            button("AC", Colors.orange),
                            button("⌫", Colors.orange),
                            button("%", Colors.orange),
                            button("÷", Colors.orange)
                          ]),
                          TableRow(children: [
                            button("7", Colors.white),
                            button("8", Colors.white),
                            button("9", Colors.white),
                            button("×", Colors.orange)
                          ]),
                          TableRow(children: [
                            button("4", Colors.white),
                            button("5", Colors.white),
                            button("6", Colors.white),
                            button("-", Colors.orange)
                          ]),
                          TableRow(children: [
                            button("1", Colors.white),
                            button("2", Colors.white),
                            button("3", Colors.white),
                            button("+", Colors.orange),
                          ]),
                          TableRow(children: [
                            button(" ", Colors.orange),
                            button("0", Colors.white),
                            button(".", Colors.white),
                            button("=", Colors.orange),
                          ])
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container button(String operator, Color color) {
    return Container(
      margin: EdgeInsets.all(1),
      color: Colors.black,
      child: FlatButton(
        height: 90,
        onPressed: () => buttonPressed(operator),
        child: Text(
          "$operator",
          style: TextStyle(
              color: color, fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
    );
  }
}
