//Sử dụng Key để bảo tồn, để giữ lại cái State khi các Widget bị di chuyển tùm lum chỗ quanh cái Widget Tree.
// Trường hợp swap 2 widget ở 2 vị trí xa xôi khác nhau 

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

// Widget Counter nắm giữ biến counter và có 1 GlobalKey được gán vào Widget này
// Khởi tạo 1 class CounterState
class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  CounterState createState() => CounterState();
}

class CounterState extends State<Counter> {
  int counter = 0;

  void incrementCounter() {
    counter++;
  }

  @override
  Widget build(BuildContext context) {
    return Text('$counter', style: Theme.of(context).textTheme.headline4);
  }
}


// Màn hình 1
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final counterKey = GlobalKey<CounterState>();    //Đây là khai báo 1 global key của 1 đối tượng CounterState
                                                  // Khai báo globalkey này chỉ khai báo 1 lần 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Thậm chí đưa data lên tới tận đây: ${counterKey.currentState?.counter ?? 0}'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Miễn có GlobalKey là chỗ nào cũng có thể truy cập: ${counterKey.currentState?.counter ?? 0}'),
              Counter(key: counterKey),    // Đây là nơi khởi tạo ra 1 widget có sử dụng cái GlobalKey 
                                          // Khởi tạo cái widget chứa global key này cũng chỉ khởi tạo 1 lần 
              FlatButton(   
                child: Text('Qua màn khác'),
                color: Colors.pink,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => SecondPage(counterKey: counterKey)
                  ));
                },
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              counterKey.currentState!.incrementCounter();   // gọi hàm của đối tượng Counter
            });
          },
        ),
      ),
    );
  }
}



// màn hình thứ 2
class SecondPage extends StatefulWidget {
  SecondPage({Key? key, required this.counterKey}) : super(key: key);

  final GlobalKey<CounterState> counterKey;   // constructor nhận vào 1 cái global key 

  @override
  State<StatefulWidget> createState() {
    return SecondPageState();
  }
}

class SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'Du lịch qua màn hình mới: ${widget.counterKey.currentState?.counter ?? 0}',
                style: Theme.of(context).textTheme.headline5
            ),
            FlatButton(
              child: Text('Về lại màn cũ'),
              color: Colors.orange,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              widget.counterKey.currentState?.incrementCounter();
            });
          }),
    );
  }
}
