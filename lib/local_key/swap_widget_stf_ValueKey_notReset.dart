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
            // Quyết định giá trị của Key luôn -- sau rebuild cũng nhận gía trị đó
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

// Mỗi lần ấn rebuild bởi hàm setState thì giá trị của ô TextField bị clean hết -  mất hết dữ liệu
/**
 Trong ví dụ ValueKey thì Element nó thấy widget cũ và widget mới đều trùng Widget Type (cùng là type TextField) 
 và trùng cả Key (TextField ở trên trước khi rebuild có key = 1, sau khi rebuild cũng có key = 1, 
 tương tự TextField ở dưới có key = 2, sau khi rebuild cũng có key = 2) nên cả 2 Element TextField trên và dưới, 
 nó chỉ cập nhật lại biến widget trỏ đến Widget mới chứ nó không bị deactivate hay bị dispose.
  Vì thế State của cả 2 Element này được bảo toàn.
 */

/**
 Câu 1: nếu trong ví dụ lần này, mình không sử dụng ValueKey, cũng không sử dụng UniqueKey, nói chung là không sử dụng Key thì kết quả sẽ như thế nào, Element TextField có bị deactivate hay bị dispose không?

Trả lời: không bị deactivate cũng không bị dispose.
Vì ko có key thì Element chỉ so sánh Widget Type và nó thấy cùng type là TextField nên nó chỉ cập nhật cho biến widget trỏ đến Widget mới, 
Element và State vẫn được bảo toàn.


 */
