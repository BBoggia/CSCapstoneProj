import 'package:flutter/material.dart';

class UserMainPage extends StatefulWidget {
  @override
  _UserMainPageState createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  void _incrementCounter() {
    setState(() {
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (ctxt) => new UserMainPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Home'),
      ),
      body: Container(
        child: Column(children: <Widget>[
          Container(
            child: Text(
              'Last 5 Days:',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
            margin: EdgeInsets.fromLTRB(32, 0, 0, 0),
            alignment: Alignment.bottomLeft,
          ),
          RecentInputSlider(),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[400]),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              margin: EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 0.0),
              child: Column(children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 7.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 150.0,
                        child: ElevatedButton(
                            child: Text("Last Entry"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserMainPage()),
                              );
                            }),
                      ),
                      Container(
                        width: 150.0,
                        child: ElevatedButton(
                            child: Text("Account"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserMainPage()),
                              );
                            }),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 7.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 150.0,
                        child: ElevatedButton(
                            child: Text("Last Entry"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserMainPage()),
                              );
                            }),
                      ),
                      Container(
                        width: 150.0,
                        child: ElevatedButton(
                            child: Text("Account"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserMainPage()),
                              );
                            }),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 7.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 150.0,
                        child: ElevatedButton(
                            child: Text("Last Entry"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserMainPage()),
                              );
                            }),
                      ),
                      Container(
                        width: 150.0,
                        child: ElevatedButton(
                            child: Text("Account"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserMainPage()),
                              );
                            }),
                      )
                    ],
                  ),
                )
              ]))
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (_incrementCounter),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class RecentInputSlider extends StatefulWidget {
  @override
  RecentInputSliderState createState() => RecentInputSliderState();
}

class RecentInputSliderState extends State<RecentInputSlider> {
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[400]),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
      height: 150.0,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            width: 160.0,
            color: Colors.red,
          ),
          Container(
            width: 160.0,
            color: Colors.blue,
          ),
          Container(
            width: 160.0,
            color: Colors.green,
          ),
          Container(
            width: 160.0,
            color: Colors.yellow,
          ),
        ],
      ),
    );
  }
}
