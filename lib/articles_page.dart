import 'package:flutter/material.dart';

class ArticlesPage extends StatefulWidget {
  @override
  _ArticlesPage createState() => new _ArticlesPage();
}

class _ArticlesPage extends State<ArticlesPage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Scaffold(
          appBar: new AppBar(
            title: new Text('Articles Page'),
          ),
          body: Center(
            child: Text('This application is made by Youssef'),
          )
      ),
    );
  }
}