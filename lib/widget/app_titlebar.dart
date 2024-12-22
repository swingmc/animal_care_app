import 'package:flutter/material.dart';
import 'package:animalCare/util/color.dart';
import 'package:animalCare/util/text.dart';
import 'package:animalCare/util/export_file.dart';

appTitleBar(String title, {List<Widget>? actions = null, double elevation = 0.0, void Function()? onPressReturn, bool isTransparent = false}) {
  return AppBar(
    leading: ReturnButton(
      onPressed: onPressReturn,
    ),
    centerTitle: true,
    backgroundColor: isTransparent ? Colors.transparent : Colors.white,
    elevation: elevation,
    title: textTitle(title),
    actions: actions,
  );
}

appTransparentBar({void Function()? onPressReturn, String title = ""}) {
  return AppBar(
    leading: ReturnButton(
      onPressed: onPressReturn,
    ),
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: textTitle(title),
  );
}

// copied by BackButton
class ReturnButton extends StatelessWidget {

  const ReturnButton({super.key, this.onPressed, this.isCollection = false});

  final VoidCallback? onPressed;
  final bool isCollection;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    return Container(
      width: 24,
      height: 24,
      margin: EdgeInsets.only(left: 12),
      alignment: Alignment.center,
      child: IconButton(
        icon: Image.asset(USERCENTER_ICON_RETURN, color: isCollection ? Colors.white : null,),
        tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        onPressed: () {
          if (onPressed != null) {
            onPressed!();
          } else {
            Navigator.maybePop(context);
          }
        },
      ),
    );
  }
}