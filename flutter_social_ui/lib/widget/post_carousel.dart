import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_ui/models/post_model.dart';

class PostCarousel extends StatelessWidget {
  final PageController pageController;
  final List<Post> posts;
  final String title;
  PostCarousel({this.posts, this.title, this.pageController});
  _buildPost(BuildContext context, int index) {
    Post post = posts[index];

    return AnimatedBuilder(
      animation: pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (pageController.position.haveDimensions) {
          value = pageController.page - index;
          value = 1 - (value.abs() * 0.25).clamp(0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 400,
            child: widget,
          ),
        );
      },
      child: Stack(
        children: <Widget>[
          Container(
            height: 400,
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                  blurRadius: 6,
                )
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: Image(
                image: AssetImage(post.imageUrl),
                height: 400,
                width: 300,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10.0,
            child: Container(
                padding: EdgeInsets.all(12.0),
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0)),
                  color: Colors.white54,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      post.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(post.location,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        )),
                    SizedBox(height: 6.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.favorite,
                              size: 30,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(post.likes.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.comment,
                              size: 30,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              post.comments.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              letterSpacing: 2.0,
            ),
          ),
        ),
        Container(
          height: 400,
          child: PageView.builder(
              controller: pageController,
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return _buildPost(context, index);
              }),
        ),
      ],
    );
  }
}
