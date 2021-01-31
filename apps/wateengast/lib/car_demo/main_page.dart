import 'package:flutter/material.dart';
import 'package:wateengast/car_demo/postlist_database.dart';
import 'package:wateengast/models/singlepost.dart';
import 'package:wateengast/resources/wordpress_api.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  final db = PostlistDatabase();
  List<SinglePost> postlist = [];

  @override
  void initState() {
    super.initState();
    setupPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: <Widget>[
          _buildAddPostButton(),
          _buildAddApiButton(),
          _buildPostList(postlist),
        ],
      ),
    );
  }

  Widget _buildPostList(List<SinglePost> postlist) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: postlist.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text('Id'),
                    Text(postlist[index].id.toString()),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text('Title'),
                    Text(postlist[index].title),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text('Slug'),
                    Text(postlist[index].slug),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text('Date'),
                    Text(postlist[index].date),
                  ],
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    onPostDelete(postlist[index].id);
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildAddPostButton() {
    return RaisedButton(
      child: Text('Add Post'),
      onPressed: () {
        //onPostPressed();
      },
    );
  }

  Widget _buildAddApiButton() {
    return RaisedButton(
      child: Text('Add API Post'),
      onPressed: () {
        onPostApiPressed();
      },
    );
  }

  onPostDelete(int id) async {
    await db.removePost(id);
    db.fetchAll().then((postDb) => postlist = postDb);
    setState(() {});
  }

  // void onPostPressed() async {
  //   var post = new SinglePost.random();
  //   await db.addPost(post);
  //   setupPostList();
  // }

  void onPostApiPressed() async {
    WordpressAPI().getPosts('2021-01-01T00:00:00').then((response) {
      for (var item in response) {
        db.addPost(item);
      }
      setupPostList();
    });
  }

  void setupPostList() async {
    var _posts = await db.fetchAll();
    print(_posts);

    setState(() {
      postlist = _posts;
    });
  }
}
