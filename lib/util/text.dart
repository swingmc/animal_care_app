import 'package:flutter/cupertino.dart';
import 'package:animalCare/util/color.dart';

textName(String data, {TextOverflow overflow = TextOverflow.fade, bool softWrap = false}) {
  return Text(
    data,
    style: TextStyle(
        color: titleColor, fontSize: 27, fontWeight: FontWeight.w500),
    overflow: overflow,
    softWrap: softWrap,
  );
}

firstLevelTitle(String data) {
  return Text(
    data,
    style: TextStyle(
        color: titleColor, fontSize: 30, fontWeight: FontWeight.w700),
  );
}

textAppTitle(String data) {
  return Text(
    data,
    style: TextStyle(
        color: titleColor, fontSize: 18, fontWeight: FontWeight.w500),
  );
}

textTitle(String data) {
  return Text(
      data,
      style: TextStyle(
          color: titleColor, fontSize: 20, fontWeight: FontWeight.w500)
  );
}

textTag(String data, {TextOverflow overflow = TextOverflow.ellipsis, bool softWrap = false}) {
  return Text(
    data,
    style: TextStyle(color: tagColor, fontSize: 14, fontWeight: FontWeight.w300),
    overflow: overflow,
    softWrap: softWrap,
  );
}

textTag01(String data) {
  return Text(
    data,
    style: TextStyle(color: buttonTagColor_01, fontSize: 14),
  );
}

textTag02(String data) {
  return Text(
    data,
    style: TextStyle(color: tagColor, fontSize: 16, fontWeight: FontWeight.w300),
    overflow: TextOverflow.ellipsis,
  );
}

text(String data) {
  return Text(
    data,
    style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w300),
  );
}

labelItem(String data) {
  return Text(
    data,
    style: TextStyle(color: inputTextColor, fontSize: 16, fontWeight: FontWeight.w400),
  );
}

text_popver(String data, {TextAlign textAlign = TextAlign.center}) {
  return Text(
    data,
    style: TextStyle(color: textColor, fontSize: 16,),
    textAlign: textAlign,
  );
}

text_01(String data) {
  return Text(
    data,
    style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w500),
  );
}



gridTitleText(String data) {
  return Text(
    data,
    style: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.w600),
  );
}

