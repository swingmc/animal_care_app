import 'package:flutter/material.dart';

import '../util/color.dart';
import '../util/text.dart';

class InfoTextItem extends StatelessWidget {

  final String? label;
  final String? text;
  final String rightIconPath;
  final bool readOnly;

  const InfoTextItem(
      {Key? key,
        required this.label,
        required this.text,
        this.rightIconPath = "",
        this.readOnly = true,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!readOnly) {

        }
      },
      child: Container(
          height: 80,
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: borderColor,
                      width: 1
                  )
              )
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 24),
                alignment: Alignment.topLeft,
                child: labelItem(label ?? ""),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      text ?? "",
                      style: TextStyle(
                        color: readOnly ? buttonTagColor_01 : textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      )),
                  Visibility(
                    visible: !readOnly,
                    child: Image.asset(
                        rightIconPath,
                        width: 24,
                        height: 24),
                  )
                ],
              )
            ],
          )),
    );
  }
}
