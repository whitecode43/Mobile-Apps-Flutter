import 'package:flutter/material.dart';
import 'constants.dart';

class ButtomButton extends StatelessWidget {
  ButtomButton({@required this.onPressed, @required this.buttonText});
  final Function onPressed;

  final String buttonText;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          alignment: Alignment.center,
          child: Text(
            buttonText,
            style: kLargeButtonText,
          ),
          margin: EdgeInsets.only(top: 10.0),
          color: kLowContainerColor,
          width: double.infinity,
          height: kLowContainerHeight),
    );
  }
}
