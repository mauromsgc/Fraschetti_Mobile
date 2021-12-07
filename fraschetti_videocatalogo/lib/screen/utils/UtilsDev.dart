import 'package:flutter/material.dart';

class MyBoxDecoration extends BoxDecoration{
  MyBoxDecoration() {
  }

  BoxDecoration MyBox() {
    return BoxDecoration(
      border: MyBorder().MyBorderOrange(),
    );
  }

}

class MyBorder extends Border{
  MyBorder() {
  }

  Border MyBorderOrange() {
    return Border.all(
      color: Colors.orange,
      width: 2,
    );

    // return Border(
    //
    // );
  }

}