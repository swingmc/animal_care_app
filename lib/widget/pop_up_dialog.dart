import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animalCare/util/export_file.dart';

class ConfirmDialog extends StatelessWidget {
  final String? topic;
  final String content;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  ConfirmDialog(this.content, {
    this.topic = "",
    this.confirmText = "Ok",
    this.cancelText = "Cancel",
    this.onConfirm = doNothing,
    this.onCancel = doNothing,
  });

  static doNothing(){}

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: topic == null ? null : gridTitleText(topic!),
      content: text_01(content),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(cancelText, style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: buttonTagColor_01)),
          onPressed: (){onCancel(); Navigator.pop(context);},
        ),
        CupertinoDialogAction(
          child: Text(confirmText, style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: buttonTagColor),
          ),
          onPressed: onConfirm,
        ),
      ],
    );
  }
}

class NotificationDialog extends StatelessWidget {
  final String? topic;
  final String content;
  final String? confirmText;
  final VoidCallback onTap;

  NotificationDialog(this.content, {
    this.topic = "",
    this.confirmText = "Ok",
    this.onTap = doNothing,
  });

  static doNothing(){}

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: topic == null?null:textAppTitle(topic ?? ""),
      content: Text(content),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(confirmText??'Ok', style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: buttonTagColor_01)),
          onPressed: onTap,
        ),
      ],
    );
  }
}

showNotification(BuildContext context, String content, {String? topic, String? confirmText, VoidCallback? onTap}){
  showDialog(
    context: context,
    builder: (BuildContext context) => NotificationDialog(
      content,
      topic: topic,
      confirmText: confirmText,
      onTap: () {
        if(onTap != null) {
          onTap();
        }
        Navigator.pop(context);
      },
    ),
  );
}

showConfirmDialog(BuildContext context, String content, Function() onConfirm, {String? topic, String confirmText = "Ok"}){
  showDialog(
    context: context,
    builder: (BuildContext context) => ConfirmDialog(
      content,
      topic: topic,
      confirmText: confirmText,
      onConfirm: () {
        onConfirm();
        Navigator.pop(context);
      },
    ),
  );
}