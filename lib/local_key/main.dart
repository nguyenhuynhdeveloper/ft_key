// import 'dart:math';

// Bài 6:  viblo
// https://viblo.asia/p/hoc-flutter-tu-co-ban-den-nang-cao-phan-6-key-la-gi-co-mo-khoa-trai-tim-nang-duoc-khong-ORNZqk4q50n

// Nếu không sử dụng key thì state của widget sẽ không bị swap cho nhau , gây ra màu vẫn giữ nguyên

import 'package:flutter/material.dart';
// import 'package:flutter/lib/local_key/swap_widget_stf_UniqueKey_haveReset.dart';

// import '../global_key/swap_widget.dart';
// import '../global_key/move_state.dart';

// import 'package:demo_ft_key/global_key/move_state.dart';
// import 'package:demo_ft_key/local_key/swap_widget_StatelessWidget.dart';

// import 'package:demo_ft_key/local_key/swap_widget_stf_notUseKey.dart';

import 'package:demo_ft_key/local_key/swap_widget_stf_UniqueKey_sameLevel.dart';
// import 'package:demo_ft_key/local_key/swap_widget_stf_UniqueKey_otherLevel.dart';

// import 'package:demo_ft_key/local_key/swap_widget_stf_UniqueKey_haveReset.dart';
// import 'package:demo_ft_key/local_key/swap_widget_stf_ValueKey_notReset.dart';

// KHÔNG SỬ DỤNG KEY CŨNG CÓ THỂ SWAP SWAP2 WIDGET

void main() {
  runApp(MyApp());
}



/**
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


  /**
    Sự khác nhau giữa so sánh == và identical
   void main() {
  final userA = User(1, 'Minh');
  final userB = User(1, 'Minh');

  // Toán tử == sẽ so sánh giá trị
  print(userA == userB); // true vì cả userA và userB đều có id là 1 và name là Minh

  // hàm identical sẽ kiểm tra xem userA với userB có cùng trỏ đến 1 object không
  print(identical(userA, userB)); // false vì userA và userB không cùng trỏ đến 1 object

  final userC = userA; // userC trỏ đến cùng object với userA
  print(identical(userA, userC)); // nên hàm identical print ra true
}

class User {
  User(this.id, this.name);

  final int id;
  final String name;
  
  // ta sẽ override lại toán tử ==
  // tức là ta định nghĩa lại "Khi nào thì 2 User gọi là == nhau)
  @override
  bool operator ==(Object other) {
    // Khi 2 user có cùng id và cùng name thì chúng bằng nhau
    return id == (other as User).id && name == (other as User).name;
  }
}

   */