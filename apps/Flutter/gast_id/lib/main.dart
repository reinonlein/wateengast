import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: GastCard(),
  ));
}

class GastCard extends StatefulWidget {
  @override
  _GastCardState createState() => _GastCardState();
}

class _GastCardState extends State<GastCard> {
  int gastLevel = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Wateengast ID Card'),
        elevation: 0,
        backgroundColor: Colors.grey[850],
        centerTitle: true,
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      gastLevel -= 1;
                    });
                  },
                  child:
                      Icon(Icons.remove, color: Colors.grey[800], size: 25.0),
                  backgroundColor: Colors.amberAccent[200],
                ),
                SizedBox(width: 10.0),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      gastLevel += 1;
                    });
                  },
                  child: Icon(Icons.add, color: Colors.grey[800], size: 25.0),
                  backgroundColor: Colors.amberAccent[200],
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/reingast.jpg'),
                radius: 50.0,
              ),
            ),
            Divider(
              height: 90.0,
              color: Colors.grey[600],
            ),
            Text(
              'NAAM',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'ReinOnlein',
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'WATEENGAST LEVEL',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '$gastLevel',
              style: TextStyle(
                color: Colors.amberAccent[200],
                letterSpacing: 2.0,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.email,
                  color: Colors.grey[400],
                ),
                SizedBox(width: 10.0),
                Text('contact@reinonlein.nl',
                    style: TextStyle(
                      color: Colors.grey[400],
                      letterSpacing: 2.0,
                      fontSize: 18.0,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
