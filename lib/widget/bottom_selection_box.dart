import 'package:flutter/material.dart';
import 'package:animalCare/util/export_file.dart';

void showBottomPopup(BuildContext context, Widget selections) {
  showModalBottomSheet<void>(
    backgroundColor: Colors.white,
    context: context,
    builder: (BuildContext context) {
      return Container(
        //color: Colors.grey.withOpacity(0.7), // Gray overlay
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            selections,
            Container(
              height: 8,
              color: bottomListGapColor,
            ),
            Container(
              alignment: Alignment.topCenter,
              height: 70,
              child: TextButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                      color: buttonTagColor_01,
                      fontWeight: FontWeight.w600,
                      fontSize: 16
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // Close the bottom popup
                },
              ),
            )
          ],
        ),
      );
    },
  );
}