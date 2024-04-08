// Nguồn Báo Viblo
// https://viblo.asia/p/hoc-flutter-tu-co-ban-den-nang-cao-phan-6-key-la-gi-co-mo-khoa-trai-tim-nang-duoc-khong-ORNZqk4q50n

// Phần 1  :  VÍ DỤ SWAP ĐƯỢC CẢ WIDGET VÀ STATE

import 'dart:math';
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
  // Biến này chính là chứa View giao diện
  var listTile = <Widget>[
    Tile(key: UniqueKey()),
    Tile(key: UniqueKey())
  ]; // Sử dụng UniqueKey() để element có thể thay đổi cả widget và cả state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children:[
            ...listTile,
            Text('UniqueKey same level'),
          ]
        ),
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
  Tile({Key? key}) : super(key: key); // thêm dòng này

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

/**
Nếu Tile là StatefulWidget thì Element sẽ quản lý cả State qua biến _state và quản lý Widget qua biến widget
Key là một định danh dùng để xác định danh tính cho các Widget, Element

 Nói một cách dễ hiểu hơn. Bình thường, nếu không có key thì Element và Widget chỉ là những kẻ vô danh.
 Có key rồi, nó giống như có một cái chứng minh nhân dân vậy, nó được xác định danh tính rõ ràng nhờ giá trị bên trong Key. 
 Nhờ có danh tính rõ ràng mà Flutter sẽ dựa vào danh tính đó để tìm kiếm
 Nếu Widget được khai báo Key thì Element không chỉ so sánh Widget Type mà còn so sánh cả Key của widget cũ mà nó đang giữ tham chiếu và widget mới nữa.
 Cụ thể sẽ có 3 tình huống xảy ra trong quá trình so sánh:

- Nếu cả Widget Type và Key đều giống nhau thì nó sẽ chỉ update bản thân nó bằng cách cho biến widget trỏ đến Widget mới.
- Nếu cùng Widget Type nhưng Key khác nhau thì Element đó sẽ bị deactivate.
- Nếu Widget Type khác nhau thì Element đó sẽ bị dispose

 Element bị dispose chính là bị destroy vĩnh viễn ra khỏi Element Tree, giống như ở bài 5 mình nói là Element bị rebuild là bị đập đi xây lại đó.
  Dispose tương đương với đập đi, đập chết nó luôn =)).
   Còn Element bị Deactivate tức là tạm thời nó bị gỡ khỏi Element Tree thôi, nó vẫn có thể được di chuyển đến vị trí khác và được gắn lại vào cây ở vị trí mới nào đó.


 Từ lý thuyết trên, tự rút ra cho mình một cái tip là LocalKey chỉ nên được đặt ở các Widget là top level, level cao nhất trong list children của một Row hoặc một Column.
  Một Column/Row, nó có nhiều đứa con có cùng một level, Flutter sẽ tìm trong mấy đứa con cùng level đó. 
 */
