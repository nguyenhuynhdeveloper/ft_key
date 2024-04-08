//UniqueKey()
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("UniqueKey have Reset ");
    }
    return Scaffold(
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('UniqueKey have Reset'),
            TextField(key: UniqueKey()),
            TextField(key: UniqueKey()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: thichThiRebuild,
        child: const Icon(Icons.swap_horiz),
      ),
    );
  }

  void thichThiRebuild() {
    setState(() {
      // ko cần làm gì cả, thích rebuild chơi thôi
    });
  }
}
