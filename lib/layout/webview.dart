
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class webview extends StatelessWidget {
  String ?intialurl;
  webview(url){
    intialurl=url;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.brown,
      title: Text('اخبار',style: TextStyle(color: Colors.white,fontSize: 35),)),
      body: WebView(initialUrl:intialurl),

    );
  }
}
