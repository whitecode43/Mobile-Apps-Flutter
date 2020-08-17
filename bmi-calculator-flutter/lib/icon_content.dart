import 'package:flutter/material.dart';
import 'constants.dart';

class IconContent extends StatelessWidget {
  final String label;
  final IconData icon;
  IconContent({this.label, this.icon});
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: kIconSize,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            label,
            style: kIconTextStyle,
          ),
        ]);
  }
}
