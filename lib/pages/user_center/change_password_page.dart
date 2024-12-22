import 'package:flutter/material.dart';
import 'package:animalCare/http/dao/user_center_dao.dart';
import 'package:animalCare/widget/general_button.dart';
import 'package:animalCare/util/export_file.dart';
import 'package:animalCare/core/app_state.dart';
import 'package:animalCare/widget/login_input.dart';

import 'package:animalCare/widget/pop_up_dialog.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage();

  @override
  _ChangePasswordPage createState() => _ChangePasswordPage();
}

class _ChangePasswordPage extends PageState<ChangePasswordPage> {
  String oldPassword = "";
  String newPassword = "";
  String confirmPassword = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appTitleBar("Change password"),
      body: Container(
        //constraints: BoxConstraints(
        //  minHeight: double.infinity,
        //  minWidth: double.infinity,
        //),
          child: Column(
            children: [
              Expanded(
                  flex: 10,
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    //   margin: EdgeInsets.only(top: 40),
                      //padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          LoginInput(
                            Image.asset(PASSWORD_ICON), "Old password",
                            onChanged: (String s) {
                              oldPassword = s;
                            },),
                          LoginInput(
                            Image.asset(PASSWORD_ICON), "New password",
                            obscureText: true,
                            buttonImagePath: EYES_ICON,
                            rightButtonCallback: SetPasswordViewable,
                            onChanged: (String s) {
                              newPassword = s;
                            },),
                          LoginInput(
                            Image.asset(PASSWORD_ICON),
                            buttonImagePath: EYES_ICON,
                            rightButtonCallback: SetPasswordViewable,
                            "Confirm new password", obscureText: true,
                            onChanged: (String s) {
                              confirmPassword = s;
                            },),
                        ],
                      )
                  )
              ),
              Expanded(
                  flex: 15,
                  child: Container()),
              Expanded(
                  flex: 8,
                  child: Container(
                      alignment: Alignment.topCenter,
                      child: ClickCustomButton(label: "Confirm Modification",
                          onPressed: changePassword)
                  )
              ),
            ],
          )
      ),
    );
  }

  changePassword() async {
    if (confirmPassword != newPassword) {
      showNotification(
          context, "confirm password is different from new password");
    } else {
      ResultPlaceholder result = await UserCenterDao.change_password(
          oldPassword, newPassword);
      if (result.code == "0") {
        showNotification(context, "change password success");
        Navigator.pop(context);
      } else if (result.code == "1000") {
        showNotification(context, "old password is wrong");
      }
    }
  }
}