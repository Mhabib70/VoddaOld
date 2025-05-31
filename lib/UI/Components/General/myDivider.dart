import 'package:flutter/material.dart';
import 'package:vodda_old/Public/config.dart';
import 'package:vodda_old/Public/styles.dart';

class MyDivider extends StatelessWidget {
  double padding;
  MyDivider({this.padding = 0});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: itemColor5,
      margin: EdgeInsets.only(left: padding, right: padding),
    );
  }
}
