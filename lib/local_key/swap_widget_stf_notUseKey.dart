import 'dart:math';
import 'package:flutter/material.dart';

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
  // Biến này chính là chứa View giao diện
  var listTile = <Widget>[
    Tile(),
    Tile()
  ]; // Sử dụng UniqueKey() để element có thể thay đổi cả widget và cả state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(children: [
          ...listTile,
          Text('UniqueKey same level'),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: swapTwoTileWidget,
        child: const Icon(Icons.swap_horiz),
      ),
    );
  }

  void swapTwoTileWidget() {
    setState(() {
      listTile.insert(1, listTile.removeAt(0));
      // Thay đổi vị trí của 2 phần tử trong mảng
    });
  }
}

class Tile extends StatefulWidget {
  Tile() : super(); // thêm dòng này

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  final Color color = generateRandomColor();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: 100,
      height: 100,
      child:
          Center(child: Text('(${color.red}, ${color.green}, ${color.blue})')),
    );
  }
}

Color generateRandomColor() {
  final Random random = Random();

  return Color.fromRGBO(
      random.nextInt(255), random.nextInt(255), random.nextInt(255), 1);
}
