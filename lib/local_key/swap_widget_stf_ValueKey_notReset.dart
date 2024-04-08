// Sự khác biệt giữa ValueKey và UniqueKey
// ValueKey(): Khi rebuild lại không bị reset lại trắng
// UniqueKey() : Khi rebuild lại sẽ reset lại trắng

// Sử dụng Key để bảo tồn, để giữ lại cái State khi các Widget bị di chuyển tùm lum chỗ quanh cái Widget Tree.

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(key: ValueKey(1)),
            TextField(key: ValueKey(2)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: thichThiRebuild,
        child: Icon(Icons.swap_horiz),
      ),
    );
  }

  void thichThiRebuild() {
    setState(() {
      // ko cần làm gì cả, thích rebuild chơi thôi
    });
  }
}
