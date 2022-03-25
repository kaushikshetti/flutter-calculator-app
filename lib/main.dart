import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  buttonPressed(String buttonText){
     setState(() {
        if(buttonText == "C"){
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      }

      else if(buttonText == "⌫"){
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if(equation == ""){
          equation = "0";
        }
      }
        else if(buttonText == "="){
        equationFontSize = 38.0;
        resultFontSize = 48.0;
            expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

   try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "Error";
        }
    
      

      }
        else{
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if(equation == "0"){
          equation = buttonText;
        }else {
          equation = equation + buttonText;
        }
      }
     });
  }

Widget buildButton(String buttonText, double buttonHeight, Color buttonColor) {
  return Container(
    //Getting some error in MediaQuery.of(context)
    // height: MediaQuery.of(context).size.height * 0.1*buttonHeight,
    height:100*buttonHeight,
    color: buttonColor,
    //FlatButton is depracated for some reasons and Flat Button had a property shape which Elevated button does not have
    child: TextButton(
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(16.0)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(
                    color: Colors.yellow,
                    width: 1,
                    style: BorderStyle.solid,
                  )
                  )
                  )
                  ),

      //  shape:RoundedRectangleBorder(
      //    borderRadius: BorderRadius.circular(0.0)
      //  ),
      // onPressed:null,
      onPressed:()=> buttonPressed(buttonText),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Simple Calculator'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Text(
                equation,
                style: TextStyle(fontSize: equationFontSize),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Text(
                result,
                style: TextStyle(fontSize:resultFontSize ),
              ),
            ),
            //To divide the screen in half
            Expanded(
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width * .75,
                    child: Table(children: [
                      TableRow(children: [
                        buildButton("C",1,Colors.redAccent),
                        buildButton("⌫", 1, Colors.blue),
                        buildButton("÷", 1, Colors.blue),
                        ]
                       ),
                                TableRow(children: [
                        buildButton("7",1,Colors.blue),
                        buildButton("8", 1, Colors.blue),
                        buildButton("9", 1, Colors.blue),
                        ]
                       ),
                                TableRow(children: [
                        buildButton("4",1,Colors.blue),
                        buildButton("5", 1, Colors.blue),
                        buildButton("6", 1, Colors.blue),
                        ]
                       ),
                                TableRow(children: [
                        buildButton("1",1,Colors.blue),
                        buildButton("2", 1, Colors.blue),
                        buildButton("3", 1, Colors.blue),
                        ]
                       ),
                                TableRow(children: [
                        buildButton(".",1,Colors.blue),
                        buildButton("0", 1, Colors.blue),
                        buildButton("00", 1, Colors.blue),
                        ]
                       ),
                        // Container(
                          //Here i dont gett any errors of the context
                        //   height: MediaQuery.of(context).size.height * 0.1,
                        //   color: Colors.redAccent,
                        //   //FlatButton is depracated for some reasons and Flat Button had a property shape which Elevated button does not have
                        //   child: TextButton(
                        //     style: ButtonStyle(
                        //         padding: MaterialStateProperty.all<EdgeInsets>(
                        //             EdgeInsets.all(16.0)),
                        //         shape: MaterialStateProperty.all<
                        //                 RoundedRectangleBorder>(
                        //             RoundedRectangleBorder(
                        //                 borderRadius:
                        //                     BorderRadius.circular(18.0),
                        //                 side: BorderSide(
                        //                   color: Colors.yellow,
                        //                   width:1,
                        //                   style:BorderStyle.solid
                        //                   )
                        //                   )
                        //                   )
                        //                   ),

                        //     //  shape:RoundedRectangleBorder(
                        //     //    borderRadius: BorderRadius.circular(0.0)
                        //     //  ),
                        //     onPressed: null,
                        //     child: Text(
                        //       "Calculator",
                        //       style: TextStyle(
                        //         fontSize: 30,
                        //         fontWeight: FontWeight.normal,
                        //         color:Colors.white,
                        //         ),
                        //     ),
                        //   ),
                        // )
                  
                    ]
                    )
                    ),
                  Container(
                       width: MediaQuery.of(context).size.width * 0.25,
                       child: Table(
                           children: [
                              TableRow(
                        children: [
                          buildButton("×", 1, Colors.blue),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("-", 1, Colors.blue),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("+", 1, Colors.blue),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("=", 2, Colors.redAccent),
                        ]
                    ),
                           ],
                       ),
                  )
              ],
            )
          ],
        ));
  }
}
