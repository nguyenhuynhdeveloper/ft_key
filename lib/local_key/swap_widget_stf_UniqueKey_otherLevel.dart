// Phần 2 :   VÍ DỤ KHÔNG THỂ SWAP ĐƯỢC KHI KHÁC LEVEL VỚI NHAU  --- Nhưng chạy app lên thì vẫn swap như thường
//Ví dụ cho local Key : Khi 2 widget mà để key không cùng level với nhau không thể swap cho nhau được

import 'dart:math';
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
// Thằng Padding không có key, thằng Tile thì vẫn có key như này:
// Mỗi lần click là 2 cái ô vuông đổi sang một màu khác luôn
// Do LocalKey => Flutter chỉ tìm kiếm trên 1 level cụ thể chứ không tìm trong tất cả 4 Widget gồm 2 padding + 2 Tile
// Nó chỉ tìm kiếm trên level Padding

  // var listTile = <Widget>[
  //   Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Tile(key: UniqueKey()),
  //   ),
  //   Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Tile(key: UniqueKey()),
  //   )
  // ];

// Cách Fix 1 : Đưa Key lên level Padding
// key được đặt ở trên Padding thì swap đúng màu
  // var listTile = <Widget>[
  //   Padding(
  //     key: UniqueKey(),
  //     padding: const EdgeInsets.all(8.0),
  //     child: Tile(),
  //   ),
  //   Padding(
  //     key: UniqueKey(),
  //     padding: const EdgeInsets.all(8.0),
  //     child: Tile(),
  //   )
  // ];

  /**
   một cái tip là LocalKey chỉ nên được đặt ở các Widget là top level, 
   level cao nhất trong list children của một Row hoặc một Column. 
   Một Row, nó có nhiều đứa con có cùng một level, Flutter sẽ tìm trong mấy đứa con cùng level đó.


   */

// Cách Fix 2: Sử dụng  GlobalKey để Flutter tìm kiếm rộng ra
  var listTile = <Widget>[
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Tile(key: GlobalKey()),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Tile(key: GlobalKey()),
    )
  ];

  @override
  Widget build(BuildContext context) {
    print("UniqueKey others level ");
    return Scaffold(
      body: Center(
        child: Row(children: [
          Text('UniqueKey others level'),
          ...listTile,
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: swapTwoTileWidget,
        child: Icon(Icons.swap_horiz),
      ),
    );
  }

  void swapTwoTileWidget() {
    setState(() {
      listTile.insert(1, listTile.removeAt(0));
    });
  }
}

class Tile extends StatefulWidget {
  Tile({Key? key}) : super(key: key);

  @override
  _TileState createState() {
    return _TileState();
  }
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

/**
 Qua các ví dụ trên, mình xin note lại những ý chính trong bài:

Nếu cả Widget Type và Key đều giống nhau thì nó sẽ chỉ update bản thân nó bằng cách cho biến widget trỏ đến Widget mới.
Nếu cùng Widget Type nhưng Key khác nhau thì Element đó sẽ bị deactivate.
Nếu Widget Type khác nhau thì Element đó sẽ bị dispose, một Element và một State mới được tạo ra thay thế

Element bị deactivate là tạm bị gỡ ra khỏi cây, vẫn có khả năng nó được gắn lại vào cây. Còn dispose là bị gỡ ra khỏi cây vĩnh viễn, chỉ còn cách tạo ra cái Element mới thay thế
Khi Element bị deactivate, Flutter sẽ thực hiện quá trình matching up widget to elements.
Nếu Flutter mà nói "no key matching found" (không tìm thấy key nào phù hợp) thì Element cũng sẽ bị dispose. 
Nếu tìm thấy key phù hợp, Element đó sẽ cho biến widget của Element trỏ tới Widget mới đó và vì thế nó được gắn lại vào Element Tree.


 */
