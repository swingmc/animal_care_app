import 'package:flutter/material.dart';
///manage exception status
abstract class PageState<T extends StatefulWidget> extends State<T> {
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if (mounted) {
      super.setState(fn);
    } else {
      print('PageState:page is destroyed，dont run this setState():${toString()}');
    }
  }

}