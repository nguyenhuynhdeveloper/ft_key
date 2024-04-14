import 'package:demo_ft_key/global_key/controlForm_GlobalKey/User.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User user = User();
  final formStateKey = GlobalKey<FormState>();

  String? validateTen(String inputName) {
    if (inputName.isEmpty) {
      // String khác null, đồng nghĩa với validate lỗi, đây cũng chính là nội dung lỗi
      return 'Tên không được trống';
    } else {
      // String trả về là null, đồng nghĩa với validate thành công
      return null;
    }
  }

// tương tự valdate tuổi cũng thế
  String? validateTuoi(String inputAge) {
    try {
      if (int.tryParse(inputAge)! < 18) {
        // hàm tryParse giúp convert kiểu String sang int
        // nếu user nhập vào một số < 18 thì báo lỗi này
        return 'Phim cấm trẻ em dưới 18 tuổi';
      } else {
        return null; // validate thành công
      }
    } catch (e) {
      // nếu user nhập vào không phải là một số thì báo lỗi này
      return 'Bạn nhập kiểu gì để nó lỗi vậy. Nhớ nhập số nha';
    }
  }

  void saveTen(String inputName) {
    user.name = inputName; // lưu tên vào biến user
  }

  void saveTuoi(String inputAge) {
    user.age = int.tryParse(inputAge)!; // lưu tuổi vào biến user
  }

  void submitForm() {
    // Khi form gọi hàm validate thì tất cả các TextFormField sẽ gọi hàm validate.
    // Đó là sức mạnh và lý do cần sử dụng widget Form
    if (formStateKey.currentState!.validate()) {
      // Cách 2: sử dụng Form.of(context) để get được FormState gần vị trí context nhất nhưng cần đưa button làm con của Form
      // if (Form.of(context).validate()) {
      // hàm validate trả về true là thành công, false là thất bại
      print('Trước khi save: Tên: ${user.name} và tuổi: ${user.age}');
      formStateKey.currentState?.save();
      // khi form gọi hàm save thì tất cả các TextFormField sẽ gọi hàm save
      print(
          'Sau khi save: Tên: ${user.name} và tuổi: ${user.age}'); // log ra kiểm tra form lưu thành công không
    } else {
      print('Validate thất bại. Vui lòng thử lại');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Form(
        key: formStateKey, // truyền vào Form
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                // decoration là thuộc tính trang trí cho TextField cũng như TextFormField
                hintText: 'Vui lòng nhập tên',
                labelText: 'Tên',
              ),
              validator:
                  validateTen, // truyền vào một hàm được đặt tên là validateTen
              onSaved: saveTen, // truyền vào một hàm được đặt tên là saveTen
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Vui lòng nhập đúng tuổi',
                labelText: 'Tuổi',
              ),
              validator:
                  validateTuoi, // truyền vào một hàm được đặt tên là validateTuoi
              onSaved: saveTuoi, // truyền vào một hàm được đặt tên là saveTuoi
            ),
          ],
        ),
      ),
      ElevatedButton(
        child: Text('show snackbar'),
        // color: Colors.pink,
        onPressed: () {
          submitForm();
        },
      ),
    ]);
  }
}
