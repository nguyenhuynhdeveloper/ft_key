import 'package:flutter/material.dart';
// import 'package:flutter/lib/local_key/swap_widget_stf_UniqueKey_haveReset.dart';

// import 'scaffoldKey_showSnackBar.dart';
// import 'controlForm_GlobalKey/form_validate_save.dart';

import '../global_key/move_state.dart';

// KHÔNG SỬ DỤNG KEY CŨNG CÓ THỂ SWAP SWAP2 WIDGET

void main() {
  runApp(MyApp());
}


/**************************************************************
 Không được phép tồn tại 2 Widget trùng một LocalKey nếu 2 Widget đó cùng 1 Widget cha.

 Không được phép tồn tại 2 Widget sử dụng chung một GlobalKey trên phạm vi toàn app.
 
 */