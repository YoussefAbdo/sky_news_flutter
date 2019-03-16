import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;
import 'package:firebase_admob/firebase_admob.dart';
import 'dart:io' show Platform;
import 'package:firebase_messaging/firebase_messaging.dart';

//pages
import './about_page.dart';
import './description_page.dart';
import './loader.dart';

 final String adUnitId = Platform.isAndroid
    ? 'ca-app-pub-3940256099942544/1033173712'
    : 'ca-app-pub-3940256099942544/4411468910';

  final String adAppId = Platform.isAndroid
    ? "ca-app-pub-7444470694788180~6841715455"
    : "ca-app-pub-7444470694788180~4898078390";

  Timer timer;
  String url = 'https://newsapi.org/v2/top-headlines?country=eg&apiKey=597ac250047845ad8e1fa41510638df2';
  String appBarTitle = 'Flutter News';

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['flutterio', 'beautiful apps'],
  contentUrl: 'https://flutter.io',
  childDirected: false,
  testDevices: <String>[], // Android emulators are considered test devices
);

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

  //List data;
  Future<List> _makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    List data;

    setState(() {
      var jsonResponse  = convert.jsonDecode(response.body);
      data = jsonResponse ["articles"];
    });

    return data;

  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: adAppId);
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.requestNotificationPermissions();
    this._makeRequest();
    timer = Timer.periodic(Duration(seconds: 10), (Timer t) => showAd());

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:
        Container(
          child: FutureBuilder(
            future: this._makeRequest(),
              builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
              if (asyncSnapshot.data == null) {
                return Container(
                  child: Center(
                    child: ColorLoader3()
                  )
                );
              }
              else {
                return new ListView.separated(
                    itemCount: asyncSnapshot.data.length,
                    separatorBuilder: (context, i) =>
                        Divider(
                            color: Colors.black
                        ),
                    itemBuilder: (BuildContext context, i) {
                      return new ListTile(
                        title: new Text(asyncSnapshot.data[i]["title"],
                          textDirection: TextDirection.rtl,),
                        trailing: new CircleAvatar(
                          backgroundImage: new NetworkImage(
                              asyncSnapshot.data[i]["urlToImage"]),
                        ),
                        onTap: () {
                          Navigator.push(context,
                              new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                  new DescriptionPage(asyncSnapshot.data[i])));
                        },
                      );
                    });
              }
                },
        ),

        ),
      appBar: new AppBar(title: new Text(appBarTitle)),
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
              title: new Text('Egypt News'),
              onTap: () {
                Navigator.pop(context);
                url = 'https://newsapi.org/v2/top-headlines?country=eg&apiKey=597ac250047845ad8e1fa41510638df2';
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new MyApp())
                );
              },
            ),
            new ListTile(
              title: new Text('Saudi Arabia news'),
              onTap: () {
                Navigator.pop(context);
                //appBarTitle = 'Saudi Arabia news';
                url = "https://newsapi.org/v2/top-headlines?sources=google-news-sa&apiKey=597ac250047845ad8e1fa41510638df2";
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new MyApp())
                );
              },
            ),
            new ListTile(
              title: new Text('Argaam News'),
              onTap: () {
                Navigator.pop(context);
                //appBarTitle='Argaam News';
                url = 'https://newsapi.org/v2/top-headlines?sources=argaam&apiKey=597ac250047845ad8e1fa41510638df2';
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new MyApp())
                );
              },
            ),
            new ListTile(
              title: new Text('About Page'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new AboutPage())
                );
              },
            ),
            new ListTile(
              title: new Text('Show Interstitial Ad'),
              onTap: () {
                showAd();
              },
            ),
          ],
        ),
      ),
    );
  }

  void showAd () {

    InterstitialAd myInterstitial = InterstitialAd(
      // Replace the testAdUnitId with an ad unit id from the AdMob dash.
      // https://developers.google.com/admob/android/test-ads
      // https://developers.google.com/admob/ios/test-ads
      adUnitId: adUnitId,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );
    myInterstitial
      ..load()
      ..show(
        anchorType: AnchorType.bottom,
        anchorOffset: 0.0,
      );

    myInterstitial.dispose();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}