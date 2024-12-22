import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animalCare/util/color.dart';
import 'package:animalCare/util/text.dart';

import '../util/assets_path.dart';

class ClickItem extends StatefulWidget {
  final String text;
  final bool showRightArrow;
  final bool showTag;
  final bool isEvent;
  final int eventCount;
  final String tag;
  final String leftIconPath;
  final VoidCallback onPressed;
  const ClickItem(
      {Key? key,
        required this.text,
        this.showRightArrow = true,
        this.showTag = false,
        this.tag = "",
        this.isEvent = false,
        this.eventCount = 0,
        required this.leftIconPath,
        required this.onPressed,
      }) : super(key: key);

  @override
  State<ClickItem> createState() => _ClickItemState();
}

class _ClickItemState extends State<ClickItem> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            Image.asset(
                widget.leftIconPath,
                width: 20,
                height: 20
            ),
            Container(
              margin: const EdgeInsets.only(left: 12),
              child: text_popver(widget.text, textAlign: TextAlign.start),
            ),
            Expanded(
                child: Visibility(
                  visible: widget.showRightArrow,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Visibility(
                          visible: widget.showTag,
                          child: widget.isEvent ? Container(
                            width: 46,
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            decoration: const BoxDecoration(
                              color: errorInfoColor,
                              shape: BoxShape.circle
                            ),
                            child: Text(
                              widget.eventCount > 99 ? '99'
                                  : '${widget.eventCount}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ) : Container(
                            width: 46,
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                color: errorInfoColor,
                                borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              widget.tag,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          )
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Image.asset(
                          ADDDEVICE_MORE_ICON,
                          width: 20,
                          height: 20,
                        ),
                      )
                    ],
                  ),
            ))
          ],
        ),
      ),
    );
  }
}

