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

// DRAWER VOORBEELD /////////////

// drawer: Drawer(
//   child: ListView(
//     // Important: Remove any padding from the ListView.
//     padding: EdgeInsets.zero,
//     children: <Widget>[
//       DrawerHeader(
//         child: Text('Alle categoriën'),
//         decoration: BoxDecoration(
//           color: Colors.green,
//         ),
//       ),
//       ListTile(
//         title: Text('Auto en verkeer'),
//         trailing: FloatingActionButton(
//           onPressed: null,
//           mini: true,
//           elevation: 0,
//           child: Text('42'),
//         ),
//         onTap: () {
//           // Update the state of the app
//           // ...
//           // Then close the drawer
//           Navigator.pop(context);
//         },
//       ),
//       ListTile(
//         title: Text('Hobby en vrije tijd'),
//         trailing: FloatingActionButton(
//           onPressed: null,
//           mini: true,
//           elevation: 0,
//           child: Text('14'),
//         ),
//         onTap: () {
//           // Update the state of the app
//           // ...
//           // Then close the drawer
//           Navigator.pop(context);
//         },
//       ),
//     ],
//   ),
// ),

// OUDE POST DETAIL PAGE
// Container(
//   width: MediaQuery.of(context).size.width,
//   height: 220,
//   child: FadeInImage.assetNetwork(
//     placeholder: 'images/loading.gif',
//     fit: BoxFit.cover,
//     image: post['image'],
//   ),
// ),
// Padding(
//   padding: const EdgeInsets.fromLTRB(15.0, 23.0, 15.0, 5.0),
//   child: Text(post['title'],
//       textAlign: TextAlign.center,
//       style: TextStyle(
//         fontSize: 20,
//         color: Colors.green[600],
//         fontWeight: FontWeight.w700,
//         shadows: <Shadow>[
//           Shadow(
//             offset: Offset(0.0, 0.0),
//             blurRadius: 0.0,
//             color: Color.fromARGB(150, 0, 0, 0),
//           ),
//         ],
//       )),
// ),
