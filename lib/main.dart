import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CategoryGridView.dart';

void main() => runApp(MyWidget());

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
        body: CategoryWidget(),
      ),
    );
  }
}
