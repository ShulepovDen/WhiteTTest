import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pages/category_grid_page.dart';
import 'dart:io';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    MyWidget(),
  );
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Progr',
      home: Scaffold(
        // appBar: AppBar(
        //     // title: const Text('StatefullWidget'),
        //     title: Text('My Program')),
        body: CategoryGridPage(),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
