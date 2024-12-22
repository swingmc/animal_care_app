import 'package:flutter/material.dart';

Widget WrapWithSymetricBorder(Widget w, {int left = 1, mid = 13, right = 1}) {
  return Row(
    children: [
      Expanded(
          flex: left,
          child: Container()
      ),
      Expanded(
        flex: mid,
        child: w,
      ),
      Expanded(
          flex: right,
          child: Container()
      ),
    ],
  );
}

Widget WrapWithVerticalBorder(Widget w, {int top = 2, mid = 5, bottom = 2}) {
  return Column(
    children: [
      Expanded(
          flex: top,
          child: Container()
      ),
      Expanded(
        flex: mid,
        child: w,
      ),
      Expanded(
          flex: bottom,
          child: Container()
      ),
    ],
  );
}

typedef IndexedWidgetBuilder = Widget? Function(BuildContext context, int index);

Widget ColumnBuilder(BuildContext context, int itemCount, IndexedWidgetBuilder builder){
  List<Widget> widgets = [];
  for(int i =0;i<itemCount;i++){
    widgets.add(
      Expanded(
        flex: 1,
        child: builder(context, i)??Container(),
      )
    );
  }
  return Column(
    children: widgets,
  );
}