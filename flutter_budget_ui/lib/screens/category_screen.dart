import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/helper/color_helper.dart';
import 'package:flutter_budget_ui/models/category_model.dart';
import 'package:flutter_budget_ui/models/expense_model.dart';
import 'package:flutter_budget_ui/widgets/radial_painter.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;
  CategoryScreen({this.category});
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  _buildExpenses() {
    List<Widget> expensesList = [];
    widget.category.expenses.forEach((Expense element) {
      expensesList.add(
        Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            padding: EdgeInsets.all(30),
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(element.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    )),
                Text('-\$${element.cost.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ))
              ],
            )),
      );
    });
    return Column(
      children: expensesList,
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalSpent = 0;
    widget.category.expenses.forEach((Expense e) {
      totalSpent += e.cost;
    });
    double percent =
        (widget.category.maxAmount - totalSpent) / widget.category.maxAmount;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            iconSize: 30,
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ]),
              child: CustomPaint(
                foregroundPainter: RadialPainter(
                  bgColor: Colors.grey[200],
                  lineColor: getColor(context, percent),
                  percent: percent,
                  width: 18,
                ),
                child: Center(
                  child: Text(
                    '\$${(widget.category.maxAmount - totalSpent).toStringAsFixed(2)} / \$${widget.category.maxAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            _buildExpenses(),
          ],
        ),
      ),
    );
  }
}
