import 'package:flutter/material.dart';

class Blog extends StatelessWidget {
  List blogPostlist = [];

  Blog({this.blogPostlist});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: ListView.separated(
          itemCount: blogPostlist.length,
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemBuilder: (context, index) {
            {
              return ClipRRect(
                borderRadius: BorderRadius.circular(7.0),
                child: new ListTile(
                    title: Text(
                      blogPostlist[index].title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0,
                        height: 1.3,
                      ),
                    ),
                    tileColor: Colors.white,
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
                      Navigator.pushNamed(
                        context,
                        '/postdetail',
                        arguments: {
                          'title': blogPostlist[index].title,
                          'image': blogPostlist[index].image,
                          'content': blogPostlist[index].content,
                        },
                      );
                    }),
              );
            }
          }),
    );

    // return Container(
    //   child: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Text(
    //           'Hier komen straks \nalle posts van \nAlcoholvrijheid.nl', // variabele content maken?
    //           textAlign: TextAlign.center,
    //           style: TextStyle(
    //             color: Colors.white,
    //             fontWeight: FontWeight.w600,
    //             fontSize: 25,
    //           ),
    //         ),
    //         RaisedButton(
    //             child: Text('button!'),
    //             onPressed: () {
    //               print('hoi button');
    //               print(blogPostlist);
    //             }),
    //         Text(blogPostlist.length.toString()),
    //       ],
    //     ),
    //   ),
    // );
  }
}

class Blog2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'En dan hopelijk een andere pagina', // variabele content maken?
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
