import 'package:flutter/material.dart';

class DescriptionPage extends StatelessWidget {
  DescriptionPage(this.data);
  final data;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text(data["title"]),
        ),
        body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(10),
            child: new Column(
              children: <Widget> [
                Image.network(data["urlToImage"]),
                //Text(data["title"], textDirection: TextDirection.rtl,),
                Text(data["description"], textDirection: TextDirection.rtl,)
              ]

            )

        ),
      ),
      ),
    );
  }
}

