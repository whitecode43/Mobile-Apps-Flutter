import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_ui/data/data.dart';
import 'package:flutter_social_ui/widget/custom_drawer.dart';
import 'package:flutter_social_ui/widget/following_users.dart';
import 'package:flutter_social_ui/widget/post_carousel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  PageController _pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          brightness: Brightness.light,
          title: Text(
            'FRENZY',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 10.0,
            ),
          ),
          iconTheme: IconThemeData(
            color: Theme.of(context).primaryColor,
          ),
          bottom: TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Theme.of(context).primaryColor,
            indicatorWeight: 3.0,
            labelStyle: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 16.0,
            ),
            controller: _tabController,
            tabs: <Widget>[Tab(text: 'Trending'), Tab(text: 'Latest')],
          ),
        ),
        body: ListView(
          children: <Widget>[
            FollowingUsers(),
            PostCarousel(
              pageController: _pageController,
              posts: posts,
              title: 'Posts',
            )
          ],
        ));
  }
}
