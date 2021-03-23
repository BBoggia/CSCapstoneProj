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
      body: Container(child: RecentInputSlider()),
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
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[400]),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.all(15.0),
        height: 150.0,
        child: ListView(
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
      ),
    );
  }
}
