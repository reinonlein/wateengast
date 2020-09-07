import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:wateengast/models/singlepost.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

List<SinglePost> parsePosts(response) {
  final parsed = jsonDecode(response).cast<Map<String, dynamic>>();
  return parsed.map<SinglePost>((json) => SinglePost.fromJson(json)).toList();
}

class _HomeState extends State<Home> {
  Future<List> futurePostList;
  ScrollController _scrollController = new ScrollController();
  bool loading = false;
  int page = 1;
  List currentPostList = [];

  Future<List<SinglePost>> _getPosts() async {
    setState(() {
      loading = true;
    });

    var queryParameters = {
      '_embed': '',
      'per_page': '30',
      'page': page.toString(),
    };

    var uri = Uri.https('www.wateengast.nl', '/wp-json/wp/v2/posts', queryParameters);

    final response = await http.get(uri);
    setState(() {
      loading = false;
    });
    return compute(parsePosts, response.body);
  }

  @override
  void initState() {
    super.initState();
    //futurePostList = _getPosts();
    _getPosts().then((response) {
      currentPostList = response;
      setState(() {});
    });
    //loading = false;

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        // if we are at the bottom of the page
        page += 1;
        _getPosts().then((response) {
          currentPostList.addAll(response);
          setState(() {});
        });
      }
    });
  }

  _scrollToTop() {
    _scrollController.jumpTo(_scrollController.position.minScrollExtent);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wat een gast...'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Center(
          child: ListView.separated(
              controller: _scrollController,
              itemCount: currentPostList.length + 1,
              separatorBuilder: (BuildContext context, int index) => Divider(),
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                if (currentPostList.length == 0) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 200),
                      Text('Welkom bij',
                          style: TextStyle(
                            fontSize: 20,
                          )),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CircularProgressIndicator(),
                      ),
                      Text('Wat een gast 2.0!',
                          style: TextStyle(
                            fontSize: 20,
                          )),
                    ],
                  );
                  ;
                } else if (index == currentPostList.length) {
                  return new ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                    title: Text('Een momentje!'),
                    subtitle: Text('Er worden meer posts opgehaald...'),
                  );
                } else {
                  return new ListTile(
                      title: Text(currentPostList[index].title),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'images/loadingbox.gif',
                          image: currentPostList[index].thumbnail,
                        ),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(15, 4, 5, 7),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/postdetail',
                          arguments: {
                            'title': currentPostList[index].title,
                            'image': currentPostList[index].image,
                            'content': currentPostList[index].content,
                          },
                        );
                      });
                }
              })

          // child: FutureBuilder<List>(
          //   future: futurePostList,
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       return ListView.separated(
          //         controller: _scrollController,
          //         itemCount: snapshot.data.length + 1,
          //         itemBuilder: (BuildContext ctxt, int index) {
          //           if (index == snapshot.data.length) {
          //             return Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 IconButton(
          //                     icon: Icon(Icons.arrow_back),
          //                     onPressed: () {
          //                       setState(() {
          //                         if (page > 1) {
          //                           page -= 1;
          //                           futurePostList = _getPosts();
          //                           _getPosts().then((_) {
          //                             _scrollToTop();
          //                           });
          //                         }
          //                       });
          //                       print(page);
          //                     }),
          //                 loading
          //                     ? CircularProgressIndicator(
          //                         strokeWidth: 2.0,
          //                       )
          //                     : SizedBox(width: 35.0),
          //                 IconButton(
          //                     icon: Icon(Icons.arrow_forward),
          //                     onPressed: () {
          //                       setState(() {
          //                         page += 1;
          //                         futurePostList = _getPosts();
          //                         _getPosts().then((response) {
          //                           currentPostList.addAll(response);
          //                           print(currentPostList.length);
          //                           _scrollToTop();
          //                         });
          //                       });
          //                       print(page);
          //                     }),
          //               ],
          //             );
          //           } else {
          //             return new ListTile(
          //                 title: Text(snapshot.data[index].title),
          //                 leading: ClipRRect(
          //                   borderRadius: BorderRadius.circular(6.0),
          //                   child: FadeInImage.assetNetwork(
          //                     placeholder: 'images/loadingbox.gif',
          //                     image: snapshot.data[index].thumbnail,
          //                   ),
          //                 ),
          //                 contentPadding: EdgeInsets.fromLTRB(15, 4, 5, 7),
          //                 onTap: () {
          //                   Navigator.pushNamed(
          //                     context,
          //                     '/postdetail',
          //                     arguments: {
          //                       'title': snapshot.data[index].title,
          //                       'image': snapshot.data[index].image,
          //                       'content': snapshot.data[index].content,
          //                     },
          //                   );
          //                 });
          //           }
          //         },
          //         separatorBuilder: (BuildContext context, int index) => Divider(),
          //         padding: EdgeInsets.all(10),
          //       );
          //     } else if (snapshot.hasError) {
          //       return Text("${snapshot.error}");
          //     }
          //     // By default, show a loading spinner.
          //     return Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Text('Welkom bij',
          //             style: TextStyle(
          //               fontSize: 20,
          //             )),
          //         Padding(
          //           padding: const EdgeInsets.all(15),
          //           child: CircularProgressIndicator(),
          //         ),
          //         Text(
          //           'Wat een gast!',
          //           style: TextStyle(
          //             fontSize: 20,
          //             color: Colors.black,
          //           ),
          //         ),
          //       ],
          //     );
          //   },
          // ),
          ),
    );
  }
}

/* SNIPPETS - controller voor in initState(): 
 _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        // if we are at the bottom of the page
        print('Tijd voor nieuwe posts!');
        setState(() {
          page += 1;
          futurePostList = _getPosts();
        });
      }
    });
*/
