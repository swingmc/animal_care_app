import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animalCare/util/color.dart';

class CustomToast {
  static void showToast(BuildContext context, String message, {Image? icon}) {
    final double height = 80;
    final double borderRadius = 24;

    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (BuildContext context) =>
          IgnorePointer(
              ignoring: true,
              child: Material(
                  color: Colors.transparent,
                  child: Container(child: Row(
                      children: [
                        Expanded(flex: 1,
                            child: Container()),
                        Expanded(flex: 2,
                            child: Column(children: [
                              Expanded(flex: 12, child: Container()),
                              Expanded(flex: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: bottomSelectionBlankColor,
                                      borderRadius: BorderRadius.circular(
                                          borderRadius),
                                    ),
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      child: Column(children: [
                                        if(icon != null) Expanded(flex: 1,
                                            child: Container(
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.only(
                                                    top: 10),
                                                child: icon)),
                                        Expanded(
                                            flex: 1,
                                            child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  message,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight
                                                          .w600
                                                  ),
                                                ))),
                                      ]),
                                    ),
                                  )),
                              Expanded(flex: 3, child: Container()),
                            ])),
                        Expanded(flex: 1, child: Container()),
                      ]
                  ))),
    ));

    Overlay.of(context).insert(overlayEntry);

    Timer(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}
