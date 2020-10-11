import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BlogPostlist extends StatelessWidget {
  // reminder: voor statefull widgets moet je in de build widget.blogPostlist gebruiken

  final List blogPostlist;

  BlogPostlist({this.blogPostlist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.separated(
            itemCount: blogPostlist.length + 1,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            padding: EdgeInsets.all(10),
            itemBuilder: (context, index) {
              if (blogPostlist.length == 0) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Een momentje...'),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SpinKitThreeBounce(
                        color: Colors.amber,
                      ),
                    ),
                    Text('De verhalen worden opgehaald'),
                  ],
                );
              } else {
                return new ListTile(
                    title: Text(
                      blogPostlist[index].title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0,
                        height: 1.3,
                      ),
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Hero(
                        tag: 'hero-${blogPostlist[index].title}',
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/loadingbox.gif',
                          image: blogPostlist[index].thumbnail,
                        ),
                      ),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(15, 4, 5, 7),
                    onTap: () {
                      FirebaseAnalytics().logEvent(
                        name: 'read_post',
                        parameters: {'Title': blogPostlist[index].title},
                      );
                      Navigator.pushNamed(
                        context,
                        '/postdetail',
                        arguments: {
                          'title': blogPostlist[index].title,
                          'image': blogPostlist[index].image,
                          'content': blogPostlist[index].content,
                        },
                      );
                    });
              }
            }),
      ),
    );
  }
}
