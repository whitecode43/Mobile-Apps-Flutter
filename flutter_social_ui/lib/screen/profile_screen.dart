import 'package:flutter/material.dart';
import 'package:flutter_social_ui/models/user_model.dart';
import 'package:flutter_social_ui/widget/custom_drawer.dart';
import 'package:flutter_social_ui/widget/post_carousel.dart';
import 'package:flutter_social_ui/widget/profile_clipper.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  ProfileScreen({this.user});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  PageController _favoritePageController;
  PageController _yourPostsPageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _favoritePageController =
        PageController(initialPage: 0, viewportFraction: 0.8);
    _yourPostsPageController =
        PageController(initialPage: 0, viewportFraction: 0.8);
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        drawer: CustomDrawer(),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                ClipPath(
                  clipper: ProfileClipper(),
                  child: Image(
                    image: AssetImage(widget.user.backgroundImageUrl),
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  child: Container(
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 6.0,
                        offset: Offset(0, 2),
                      )
                    ]),
                    child: ClipOval(
                      child: Image(
                        height: 120,
                        width: 120,
                        image: AssetImage(widget.user.profileImageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 50,
                    left: 20,
                    child: IconButton(
                      icon: Icon(Icons.menu),
                      iconSize: 30,
                      color: Theme.of(context).primaryColor,
                      onPressed: () => _key.currentState.openDrawer(),
                    ))
              ],
            ),
            Text(widget.user.name,
                style: TextStyle(
                  fontSize: 25,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                )),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        'Following',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        widget.user.following.toString(),
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        'Followers',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        widget.user.following.toString(),
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            PostCarousel(
              pageController: _yourPostsPageController,
              title: 'Your Posts',
              posts: widget.user.posts,
            ),
            PostCarousel(
              pageController: _favoritePageController,
              title: 'Favorites',
              posts: widget.user.posts,
            ),
            SizedBox(height: 50),
          ],
        )));
  }
}
