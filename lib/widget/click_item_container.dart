import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../util/color.dart';

class ClickItemContainer extends StatelessWidget {
  final List<dynamic>? itemList;
  // final int itemNum;

  const ClickItemContainer(
      {super.key,
        required this.itemList,
        // required this.itemNum
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12, left: 24, right: 24),
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: bgColor,
        boxShadow: const [
          BoxShadow(
            color: itemContainerShadowColor,
            blurRadius: 52,
            spreadRadius: 0,
            offset: Offset(0, 12)
          )
        ]
      ),
      child: SizedBox(
          child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itemList?.length,
          itemBuilder: (context, index) {
            return itemList?[index];
          }
      )
      ),
    );
  }
}
