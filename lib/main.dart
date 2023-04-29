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

// class SimpleWidget extends StatelessWidget {
//   const SimpleWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//           //color: Colors.green,
//           child: Text(
//             'Panda',
//             style: TextStyle(fontSize: 40, color: Colors.white70),
//           ),
//           height: 200,
//           width: 200,
//           alignment: Alignment.center,
//           // padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//           margin: EdgeInsets.all(50),
//           transform: Matrix4.rotationZ(0.1),
//           decoration: BoxDecoration(
//               //gradient: LinearGradient(colors: [Colors.red, Colors.cyan])),
//               color: Colors.green,
//               image: DecorationImage(
//                   image: Image.network(
//                           'https://forsuit.ru/wa-data/public/shop/products/04/92/19204/images/16734/16734.750x0@2x.JPG')
//                       .image,
//                   fit: BoxFit.cover),
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                     color: Colors.black45,
//                     offset: Offset(-5, 5),
//                     blurRadius: 5,
//                     spreadRadius: 5),
//               ])),
//     );
//   }
// }

// class SimpleWidget extends StatefulWidget {
//   const SimpleWidget({super.key});

//   @override
//   State<SimpleWidget> createState() => _SimpleDialoWidget();
// }

// class _SimpleDialoWidget extends State<SimpleWidget> {
//   int _count = 0;
//   void _handleButton() {
//     setState(() {
//       _count++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text('$_count'),
//           ElevatedButton(onPressed: _handleButton, child: Text('Click me!'))
//         ],
//       ),
//     );
//   }
// }
// class SimpleWidget extends StatefulWidget {
//   @override
//   _SimpleWidgetState createState() => new _SimpleWidgetState();

// }

// class SimpleWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: Center(
//             child: new Text('Мой текст', textDirection: TextDirection.ltr)));
//   }
// }
