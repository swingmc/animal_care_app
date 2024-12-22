import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../util/assets_path.dart';

class CustomStackWidget extends StatelessWidget {

  final Widget widget;
  final isDeep;

  const CustomStackWidget({Key? key, required this.widget, this.isDeep = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            alignment: Alignment.topCenter,
            child: Image.asset(
              isDeep ? USERCENTER_TOP_02_BG : USERCENTER_USER_INFO_BG,
              fit: BoxFit.fitWidth,
            )),
        widget
      ],
    );
  }
}
