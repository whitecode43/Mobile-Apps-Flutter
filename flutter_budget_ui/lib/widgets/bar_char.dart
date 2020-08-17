import 'dart:math';

import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final List<double> expenses;
  BarChart({this.expenses});
  @override
  Widget build(BuildContext context) {
    double _mostExpenses = 0;
    expenses.forEach((element) {
      _mostExpenses = max(element, _mostExpenses);
    });
    return Column(
      children: <Widget>[
        Text(
          'Weekly Spending',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 5.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back),
              iconSize: 30,
            ),
            Text('Nov 10,2019 - Nov 16,2019 ',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                )),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward),
              iconSize: 30,
            ),
          ],
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Bar(
              label: 'Su',
              amountSpent: expenses[0],
              mostExpenses: _mostExpenses,
            ),
            Bar(
              label: 'Mo',
              amountSpent: expenses[1],
              mostExpenses: _mostExpenses,
            ),
            Bar(
              label: 'Tu',
              amountSpent: expenses[2],
              mostExpenses: _mostExpenses,
            ),
            Bar(
              label: 'We',
              amountSpent: expenses[3],
              mostExpenses: _mostExpenses,
            ),
            Bar(
              label: 'Th',
              amountSpent: expenses[4],
              mostExpenses: _mostExpenses,
            ),
            Bar(
              label: 'Fr',
              amountSpent: expenses[5],
              mostExpenses: _mostExpenses,
            ),
            Bar(
              label: 'Sa',
              amountSpent: expenses[6],
              mostExpenses: _mostExpenses,
            ),
          ],
        ),
      ],
    );
  }
}

class Bar extends StatelessWidget {
  final double amountSpent;
  final double mostExpenses;
  final String label;
  final double _maxheight = 150;
  Bar({this.label, this.amountSpent, this.mostExpenses});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('\$${amountSpent.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        SizedBox(
          height: 6,
        ),
        Container(
            height: amountSpent / mostExpenses * _maxheight,
            width: 18,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(6.0),
              ),
            )),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
