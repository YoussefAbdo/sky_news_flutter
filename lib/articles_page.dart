import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;

class ArticlesPage extends StatefulWidget {
  @override
  _ArticlesPage createState() => new _ArticlesPage();
}

class _ArticlesPage extends State<ArticlesPage> {

  String url = 'https://newsapi.org/v2/top-headlines?country=eg&apiKey=597ac250047845ad8e1fa41510638df2';

  Future<String> makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    //print(response.body);
    List data;

    var jsonResponse  = convert.jsonDecode(response.body);
    data = jsonResponse ["results"];
    var itemCount = jsonResponse['totalResults'];
    print("Number of books about http: $itemCount.");
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Scaffold(
          appBar: new AppBar(
            title: new Text('Articles'),
          ),
          body: Center(
            child: new RaisedButton(
    child: new Text('Make Request'),
    onPressed: makeRequest,
            )
          )
      ),
    );
  }
}