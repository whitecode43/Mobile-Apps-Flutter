import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_ui/models/food.dart';
import 'package:flutter_food_delivery_ui/models/restaurant.dart';
import 'package:flutter_food_delivery_ui/widgets/rating_starts.dart';

class RestaurantScreen extends StatefulWidget {
  final Restaurant restaurant;
  RestaurantScreen({this.restaurant});
  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  Widget _menuItemBuilder(Food menuItem) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: 175,
            width: 175,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              image: DecorationImage(
                image: AssetImage(menuItem.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 175.0,
            width: 175.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black87.withOpacity(0.3),
                  Colors.black54.withOpacity(0.3),
                  Colors.black38.withOpacity(0.3),
                ],
                stops: [0.1, 0.4, 0.6, 0.9],
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            child: Column(
              children: <Widget>[
                Container(
                  width: 175,
                  child: Center(
                    child: Text(
                      menuItem.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        letterSpacing: 1.2,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Text('\$ ${menuItem.price} ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    )),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
                width: 48,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: IconButton(
                  icon: Icon(Icons.add, size: 30, color: Colors.white),
                  onPressed: () {},
                )),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Hero(
              tag: widget.restaurant.imageUrl,
              child: Image(
                image: AssetImage(widget.restaurant.imageUrl),
                height: 250,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 50,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    iconSize: 30,
                    color: Colors.white,
                    icon: Icon(
                      Icons.arrow_back_ios,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  IconButton(
                    iconSize: 35,
                    color: Theme.of(context).primaryColor,
                    icon: Icon(
                      Icons.favorite,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.restaurant.name,
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '0.2 miles from here',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              RatingStars(rating: widget.restaurant.rating),
              SizedBox(height: 6),
              Text(
                widget.restaurant.address,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 30),
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Text('Review',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  )),
              onPressed: () {},
            ),
            FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 30),
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Text('Contact',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  )),
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(height: 10),
        Center(
          child: Text(
            'Menu',
            style: TextStyle(
                fontSize: 22, letterSpacing: 1.2, fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(widget.restaurant.menu.length, (index) {
                Food menuItem = widget.restaurant.menu[index];
                return _menuItemBuilder(menuItem);
              })),
        )
      ],
    ));
  }
}
