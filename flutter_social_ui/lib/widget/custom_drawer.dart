import 'package:flutter/material.dart';
import 'package:flutter_social_ui/data/data.dart';
import 'package:flutter_social_ui/screen/home_screen.dart';
import 'package:flutter_social_ui/screen/login_screen.dart';
import 'package:flutter_social_ui/screen/profile_screen.dart';

class CustomDrawer extends StatelessWidget {
  _buildDrawerOption(String title, Icon icon, Function onTap) {
    return ListTile(
      leading: icon,
      title: Text(title,
          style: TextStyle(
            fontSize: 20.0,
          )),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Image(
              image: AssetImage(currentUser.backgroundImageUrl),
              height: 200.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              left: 20,
              bottom: 20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 3,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      child: ClipOval(
                        child: Image(
                          image: AssetImage(currentUser.profileImageUrl),
                          fit: BoxFit.cover,
                        ),
                      )),
                  SizedBox(width: 6.0),
                  Text(currentUser.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white))
                ],
              ),
            )
          ],
        ),
        _buildDrawerOption(
            'Home',
            Icon(Icons.dashboard),
            () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => HomeScreen()))),
        _buildDrawerOption('Chat', Icon(Icons.chat), () {}),
        _buildDrawerOption('Map', Icon(Icons.location_on), () {}),
        _buildDrawerOption(
            'Your Profile',
            Icon(Icons.account_circle),
            () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => ProfileScreen(
                          user: currentUser,
                        )))),
        _buildDrawerOption('Setttings', Icon(Icons.settings), () {}),
        Expanded(
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: _buildDrawerOption(
              'Logout',
              Icon(Icons.directions_run),
              () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => LoginScreen(),
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
