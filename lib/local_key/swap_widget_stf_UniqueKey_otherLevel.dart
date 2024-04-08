
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
// key được đặt ở trên Padding
  var listTile = <Widget>[
    Padding(
      key: UniqueKey(),
      padding: const EdgeInsets.all(8.0),
      child: Tile(),
    ),
    Padding(
      key: UniqueKey(),
      padding: const EdgeInsets.all(8.0),
      child: Tile(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    print("UniqueKey others level ");
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Text('UniqueKey others level'),
            ...listTile,

          ]
        ),
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

Các loại LocalKey
Class Key nó có 2 subclass là LocalKey và GlobalKey. 
GlobalKey mình đã giới thiệu sơ ở trên rồi, mình sẽ nói nhiều hơn về GlobalKey ở bài sau. Bài lần này, mình chỉ tập trung nói về LocalKey.

Các loại LocalKey :  UniqueKey , ValueKey, ObjectKey.
Hai loại key này nó cho phép mình truyền giá trị mà mình mong muốn vào.
Ví dụ thế này: ValueKey('tui muốn giá trị của key này là 113'), ObjectKey('abc'). Nhưng phải cực kỳ cẩn thận với 2 loại key này. Bởi vì:

Tất cả Widget được khai báo Key mà có cùng một Widget cha thì các Key đó đều phải đôi một khác nhau
Tức là không có cái Key nào được phép trùng với Key khác trong phạm vi cùng một Widget cha.
Nếu bạn vi phạm, Flutter sẽ ném một lỗi: Exception: Duplicate keys found.
 Cái này không cần nói cũng biết, nếu trong ví dụ trên, 2 Widget Tile có cùng 1 key thì 1 Element nó match được với 2 Widget luôn à, điều đó là vô lý. 
 Chính vì vậy, Flutter không thể để điều vô lý đó xảy ra.
 
 Vậy ValueKey và ObjectKey có gì khác nhau. 
 Sự khác nhau ở đây là ValueKey nó so sánh giá trị, hai ValueKey có cùng giá trị (ví dụ như cùng giá trị 113 ở trên) thì được gọi là trùng nhau, 
 còn ObjectKey thì truyền vào một Object và nó sẽ so sánh địa chỉ của Object chứ không phải chỉ so sánh giá trị. 
 Nói ngắn gọn lại thì ValueKey sử dụng so sánh ==, còn ObjectKey sử dụng so sánh identical
 Well, chúng ta đã hiểu về ValueKey và ObjectKey rồi. Còn đây là định nghĩa về UniqueKey mà đã được mình sử dụng từ đầu bài:

A key that is only equal to itself.
Đúng như cái tên của nó, đã là UniqueKey thì không bao giờ có thằng thứ 2 trùng với nó trên cuộc đời này.
 */
