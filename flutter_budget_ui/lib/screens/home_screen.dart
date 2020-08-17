import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/data/data.dart';
import 'package:flutter_budget_ui/helper/color_helper.dart';
import 'package:flutter_budget_ui/models/category_model.dart';
import 'package:flutter_budget_ui/screens/category_screen.dart';
import 'package:flutter_budget_ui/widgets/bar_char.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _buildCategorie(Category category, double spentAmount) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => CategoryScreen(category: category))),
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
          padding: EdgeInsets.all(20.0),
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                )
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(category.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      )),
                  Text(
                    '\$${(category.maxAmount - spentAmount).toStringAsFixed(2)}/\$${category.maxAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraint) {
                  double maxWidth = constraint.maxWidth;
                  double percent =
                      ((category.maxAmount - spentAmount) / category.maxAmount);
                  final double width = percent >= 0 ? percent * maxWidth : 0;

                  return Stack(
                    children: <Widget>[
                      Container(
                          height: 20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          )),
                      Container(
                          height: 20,
                          width: width,
                          decoration: BoxDecoration(
                            color: getColor(context, percent),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          )),
                    ],
                  );
                },
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          forceElevated: true,
          floating: true,
          expandedHeight: 100,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(
              'Simple Budget',
            ),
          ),
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
            iconSize: 30,
            color: Colors.white,
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.add),
              iconSize: 30,
              color: Colors.white,
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              if (index == 0) {
                return Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 2),
                          blurRadius: 6.0,
                        )
                      ],
                    ),
                    child: BarChart(expenses: weeklySpending));
              } else {
                Category category = categories[index - 1];
                double spentAmount = 0;
                category.expenses.forEach((element) {
                  spentAmount += element.cost;
                });
                return _buildCategorie(category, spentAmount);
              }
            },
            childCount: 1 + categories.length,
          ),
        )
      ],
    ));
  }
}
