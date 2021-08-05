



import 'package:flutter/material.dart';

linearGradient(){
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xffee0000),
  Color(0xffeeee00)
  ],
  ).createShader(
      Rect.fromCircle(
        // center: Offset(fontSize, -200),
        // radius: fontSize / 3,
      )
  );
}