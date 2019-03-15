import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;
import './description_page.dart';

class ArgaamPage extends StatefulWidget {
  @override
  _ArgaamPage createState() => new _ArgaamPage();
}

class _ArgaamPage extends State<ArgaamPage> {

  String url = 'https://newsapi.org/v2/top-headlines?sources=argaam&apiKey=597ac250047845ad8e1fa41510638df2';
  List data;

  Future<String> makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var jsonResponse  = convert.jsonDecode(response.body);
      data = jsonResponse ["articles"];

    });

  }

  @override
  void initState() {
    this.makeRequest();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
          appBar: new AppBar(
            title: new Text('Argaam news'),
          ),
          body: new ListView.separated(
              itemCount: data == null? 0:data.length,
              separatorBuilder: (context, i) =>Divider(
                  color: Colors.black
              ),
              itemBuilder: (BuildContext context, i) {
                return new ListTile(
                  title: new Text(data[i]["title"],
                    textDirection: TextDirection.rtl,),
                  trailing: new CircleAvatar(
                    backgroundImage: new NetworkImage(data[i]["urlToImage"]),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (BuildContext context) =>
                        new DescriptionPage(data[i])));
                  },
                );
              })
    );
  }
}