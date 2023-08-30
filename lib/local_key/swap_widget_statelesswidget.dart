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
  var listTile = <Widget>[Tile(), Tile()]; // tạo 1 list lưu trữ 2 Widget

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: listTile, // Row nhận một list Widget nên mình truyền listTile vào
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: swapTwoTileWidget, // thực hiện hoán đổi vị trí 2 Widget trong listTile
        child: Icon(Icons.swap_horiz),
      ),
    );
  }

  // hàm thực hiện hoán đổi 2 Widget trong listTile
  void swapTwoTileWidget() {
    setState(() {
      listTile.insert(1, listTile.removeAt(0));
    });
  }
}

class Tile extends StatelessWidget {
  final Color color = generateRandomColor(); // khởi tạo Widget với 1 random Color

  @override
  Widget build(BuildContext context) {
    // tạm hiểu Container như cái thùng có màu sắc, kích thước => khá giống viên gạch =))
    return Container(
      color: color,
      width: 100,
      height: 100,
    );
  }
}

// hàm tạo ra một Color bất kỳ
Color generateRandomColor() {
  // biến random sẽ giúp ta tạo ra 1 số ngẫu nhiên
  final Random random = Random();

  // Màu sắc được tạo nên từ RGB, là một số ngẫu nhiên từ 0 -> 255 và opacity = 1
  return Color.fromRGBO(random.nextInt(255), random.nextInt(255), random.nextInt(255), 1);
}

/*
Giải thích hàm swap 2 phần tử trong List:
(*): Logic hàm *swap* chỗ này có thể gây khó hiểu. Giả sử ta có một `list` có 2 phần tử lần lượt theo thứ tự có tên là `A` và `B`: `[A, B]`, Để swap 2 phần tử trong một list ta cần đến 2 hàm là `removeAt` và `insert`. Đầu tiên `list` thực hiện remove phần tử index là 0, tức là remove `A` ra khỏi `list`. Hàm `removeAt` này lại trả về chính phần tử bị loại bỏ đó luôn chính là trả về `A`. Sau khi remove, lúc này `list` chỉ còn 1 phần tử duy nhất là `B` tại index là 0. Ta tiếp tục gọi hàm `insert`, để chèn phần tử vừa bị loại là `A` vào vị trí index là 1. Như vậy sau khi `insert`, `list` lại có 2 phần tử là `[B, A]` (đã swap thành công từ list ban đầu là `[A, B]`). Đáng lẽ, mình nên viết như này cho nó dễ hiểu :v

var list = ['A', 'B'];
var a = list.removeAt(0);
list.insert(1, a);
print(list); // [B, A]
*/


// Đầu tiên lúc first build thì widget Row có 2 StatelessWidget đều có kiểu là Tile, một cái màu xanh blue (đặt tên là Widget blue), một cái màu đỏ (đặt tên là Widget red). Từ 2 Widget đó, nó sẽ tạo ra 2 Element. Một thằng Element blue đang trỏ đến Widget blue, Element còn lại đặt tên là Element red đang trỏ đến Widget red

// Tiếp theo, khi swap 2 widget Tile và thực hiện rebuild: Flutter sẽ walk down Element tree, từng Element sẽ kiểm tra cái Widget Type của Widget cũ và Widget mới có giống nhau hay không?. Bắt đầu từ thằng Element blue, nó thấy thằng cũ là Widget blue, được đổi thành Widget red nên nó nói rằng: "2 thằng này cùng Widget Type là Tile nên ta sẽ chuyển con trỏ từ Widget blue sang Widget red". Tiếp tục, đến Element red cũng so sánh như vậy nên cũng chuyển sang trỏ đến widget mới là Widget blue. Tóm lại cả 2 Element đều thay đổi, trỏ đến widget mới nên UI được update.