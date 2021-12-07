import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:webview_flutter/webview_flutter.dart';



class WebViewExampleState extends StatelessWidget {
  final String webUrl;
  final String name;

  WebViewExampleState({
    required this.webUrl,
    required this.name,
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: WebView(
        initialUrl: webUrl,
      ),
    );
  }

  /// App Bar
  PreferredSizeWidget _buildAppBar(context) => AppBar(
    elevation: 5,
    backgroundColor: HexColor('1a2f3f'),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: HexColor('1a2f3f'),
    ),
    title: Row(
      children: [
        Text(
          '$name',
          style: TextStyle(color: Colors.white),
        ),
      ],
    ),
    titleSpacing: 0,
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      splashRadius: 23,
      icon: Icon(
        Icons.arrow_back_outlined,
        color: Colors.white,
      ),
    ),
  );
}