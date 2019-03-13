import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;

//pages
import './about_page.dart';
import './articles_page.dart';
import './argaam_page.dart';
import './description_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sky News',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String url = 'https://newsapi.org/v2/top-headlines?country=sa&apiKey=597ac250047845ad8e1fa41510638df2';
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
      body:new ListView.separated(
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
          }),
      appBar: new AppBar(title: new Text('Egypt News')),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: new Text('Youssef'),
                accountEmail: new Text('youssefaabdo@gmail.com'),
            currentAccountPicture: new CircleAvatar(
              backgroundImage: new NetworkImage('https://scontent-hbe1-1.xx.fbcdn.net/v/t1.0-9/1510899_10200359102779647_1273780479_n.jpg?_nc_cat=108&_nc_ht=scontent-hbe1-1.xx&oh=5d1011abcde00a19274729daece09bcc&oe=5D156FBA'),
            ),
            ),
            new ListTile(
              title: new Text('Saudi Arabia news'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new ArticlesPage())
                );
              },
            ),
            new ListTile(
              title: new Text('Argaam News'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new ArgaamPage())
                );
              },
            ),
            new ListTile(
              title: new Text('About Page'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new AboutPage())
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
