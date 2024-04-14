//UniqueKey()
import 'package:flutter/foundation.dart';
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
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("UniqueKey have Reset ");
    }
    print("Widget rebuild ");

    return Scaffold(
      body: Center(
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
      // setState sẽ làm widget bị rebuild lại ==> sinh ra 2 thằng TextField mới
    });
  }
}

// Mỗi lần ấn rebuild bởi hàm setState thì giá trị của ô TextField bị clean hết -  mất hết dữ liệu
//Trong ví dụ UniqueKey: Mỗi lần rebuild, một UniqueKey mới được tạo ra và cái UniqueKey này
//chắc chắn không bao giờ trùng với cái cũ trước đó.
// Như vậy nó rơi vào trường hợp cùng Widget Type nhưng khác Key nên Element này bị dispose.
//Vì thế một Element mới và một State mới được tạo lên dẫn đến text bị clear hết.
