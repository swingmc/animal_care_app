import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animalCare/util/color.dart';

class ClickCustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final int style;
  final bool enable;
  final double fontSize;
  final FontWeight fontWeight;

  ClickCustomButton({
    required this.label,
    required this.onPressed,
    this.style = 0,
    this.enable = true,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
        child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Container()
              ),
              Expanded(
                  flex: 8,
                  child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: enable ? (style == 1? [pureWhiteColor,pureWhiteColor]
                              : [pressButtonColorLeft, pressButtonColorRight])
                              : [buttonUnableColor, buttonUnableColor],
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                        ),
                        borderRadius: BorderRadius.circular(180),
                        border: style == 1?Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ):null,
                      ),
                      child: ElevatedButton(
                          onPressed: enable ? onPressed : null,
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all(
                                Colors.transparent),
                            //padding: EdgeInsets.symmetric(horizontal: 24.0),
                          ),
                          child: Text(
                            label,
                            style: TextStyle(
                              color: style == 1?Colors.black:Colors.white,
                              fontSize: fontSize,
                              fontWeight: fontWeight
                            ),
                            maxLines: 1,
                          )
                      )
                  )
              ),
              Expanded(
                flex: 1,
                child: Container(),
              )
            ]
        )
    );
  }
}

clickButton(String label, VoidCallback onPressed, Color color) {
  return Container(
      width: 112,
      height: 28,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [pressButtonColorLeft, pressButtonColorRight],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
          borderRadius: BorderRadius.circular(14)
      ),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(
                Colors.transparent),
            //padding: EdgeInsets.symmetric(horizontal: 24.0),
          ),
          child: Text(
            label,
            style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.bold
            ),
            maxLines: 1,
          )
      )
  );
}
