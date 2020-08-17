import 'package:bmi_calculator/main.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'resuable_cart.dart';
import 'buttom_button.dart';

class ResultPage extends StatelessWidget {
  final String bmi;
  final String result;
  final String messege;
  ResultPage(
      {@required this.bmi, @required this.result, @required this.messege});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              child: Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.all(15),
            child: Text(
              'Your Results',
              style: kResultStyle,
            ),
          )),
          Expanded(
            flex: 5,
            child: ReusableCard(
              colour: kActiveCardColour,
              childCard: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(result,
                      style: TextStyle(
                          color: Color(0xFF24D876),
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold)),
                  Text(bmi,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 100.0)),
                  Text(
                    messege,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, color: Color(0xFF8D8E98)),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: ButtomButton(
                buttonText: 'RE-CALCULATED',
                onPressed: () {
                  Navigator.pop(context);
                },
              ))
        ],
      ),
    );
  }
}
