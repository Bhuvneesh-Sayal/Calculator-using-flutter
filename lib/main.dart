import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(Calculator());
}

class Calculator extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: Calc(),
    );
  }
}

class Calc extends StatefulWidget {
  @override
  _CalcState createState() => _CalcState();
}

class _CalcState extends State<Calc> {

  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 40.0;
  double resultFontSize = 50.0;

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText=="AC"){
        equation="0";
        result="0";
        equationFontSize=40.0;
        resultFontSize=50.0;
      }

      else if(buttonText=="⌫"){
        equationFontSize=40.0;
        resultFontSize=50.0;
        equation=equation.substring(0, equation.length-1);
        if(equation==""){
          equation="0";
        }
      }

      else if(buttonText=="="){
        equationFontSize=40.0;
        resultFontSize=50.0;

        expression=equation;
        expression=expression.replaceAll('×', '*');
        expression=expression.replaceAll('÷', '/');
        expression=expression.replaceAll('√', 'sqrt');

        try{
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cm=ContextModel();
          result='${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result="Error";
        }
      }

      else{
        equationFontSize=50.0;
        resultFontSize=40.0;
        if(equation=="0"){
          equation=buttonText;
        }else{
          equation=equation+buttonText;
        }
      }
    });

  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    return  Container(
      height: MediaQuery.of(context).size.height*0.075*buttonHeight,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white,
                  width: 1,
                  style: BorderStyle.solid
              )
          ),
          padding: EdgeInsets.all(14.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.normal,
                color: Colors.white
            ),
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: Column(
        children: <Widget>[

          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text(equation, style: TextStyle(fontSize: equationFontSize),),
          ),

          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text(result, style: TextStyle(fontSize: resultFontSize),),
          ),

          Expanded(
              child: Divider(),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width*.75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("AC", 1, Colors.green),
                        buildButton("⌫", 1, Colors.blueAccent),
                        buildButton("÷", 1, Colors.blueAccent),
                      ]
                    ),

                    TableRow(
                        children: [
                          buildButton("7", 1, Colors.blueGrey),
                          buildButton("8", 1, Colors.blueGrey),
                          buildButton("9", 1, Colors.blueGrey),

                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("4", 1, Colors.blueGrey),
                          buildButton("5", 1, Colors.blueGrey),
                          buildButton("6", 1, Colors.blueGrey),

                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("1", 1, Colors.blueGrey),
                          buildButton("2", 1, Colors.blueGrey),
                          buildButton("3", 1, Colors.blueGrey),

                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton(".", 1, Colors.blueAccent),
                          buildButton("0", 1, Colors.blueGrey),
                          buildButton("^", 1, Colors.blueAccent),

                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("(", 1, Colors.blueAccent),
                          buildButton(")", 1, Colors.blueAccent),
                          buildButton("%", 1, Colors.blueAccent),

                        ]
                    ),
                  ],
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width*0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("×", 1, Colors.blueAccent),
                      ]
                    ),

                    TableRow(
                        children: [
                          buildButton("+", 1, Colors.blueAccent),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("-", 1, Colors.blueAccent),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("√", 1, Colors.blueAccent),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("=", 2, Colors.deepOrange),
                        ]
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
