import 'dart:math';

import 'package:flutter/material.dart';

class Mario extends StatelessWidget {
  final direction;
  final midrun;

  Mario({Key key, this.direction, this.midrun}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (direction == "right") {
      return Container(
        width: 150,
        height: 150,
        child: midrun
            ? Image.asset('assets/images/zaferMario.png')
            : Image.asset('assets/images/zafermarioYan.png'),
      );
    } else {
      return Transform(
        //merkezden hizalanarak y eksenine göre yansıması alınır.
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          width: 150,
          height: 150,
          child: midrun
              ? Image.asset('assets/images/zaferMario.png')
              : Image.asset('assets/images/zafermarioYan.png'),
        ),
      );
    }
  }
}
