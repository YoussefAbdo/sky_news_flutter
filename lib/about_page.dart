import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => new _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Scaffold(
      appBar: new AppBar(
        title: new Text('About Page'),
      ),
        body: Center(
          child: Text('This application is made by Youssef!'),
        )
      ),
    );
  }
}