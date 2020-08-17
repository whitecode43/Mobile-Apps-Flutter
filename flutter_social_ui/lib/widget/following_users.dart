import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_ui/data/data.dart';
import 'package:flutter_social_ui/models/user_model.dart';

class FollowingUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Text(
            'Following',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              letterSpacing: 2.0,
            ),
          ),
        ),
        Container(
            height: 80.0,
            child: ListView.builder(
              padding: EdgeInsets.only(left: 10.0),
              itemCount: users.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                User user = users[index];
                return GestureDetector(
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    height: 60.0,
                    width: 60.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 6.0),
                        ],
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2.0,
                        )),
                    child: ClipOval(
                      child: Image(
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          image: AssetImage(user.profileImageUrl)),
                    ),
                  ),
                );
              },
            ))
      ],
    );
  }
}
