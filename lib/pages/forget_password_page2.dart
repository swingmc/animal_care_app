import 'package:flutter/material.dart';
import 'package:animalCare/http/core/http_net_adapter.dart';
import 'package:animalCare/http/core/http_net_error.dart';
import 'package:animalCare/http/dao/login_dao.dart';
import 'package:animalCare/navigator/app_navigator.dart';
import 'package:animalCare/widget/app_titlebar.dart';
import 'package:animalCare/widget/general_button.dart';
import 'package:animalCare/util/export_file.dart';
import 'dart:async';

class ForgetPasswordPageTwo extends StatefulWidget {
  late String email;
  int seconds = 60;
  ForgetPasswordPageTwo({required String this.email}){}
  @override
  State<StatefulWidget> createState() => _ForgetPasswordPageTwoState(email: email);
}

class _ForgetPasswordPageTwoState extends State<ForgetPasswordPageTwo> {

  bool loginEnable = false;
  late String email;
  late Timer _timer;
  late int _remainingSeconds;

  _ForgetPasswordPageTwoState({required String this.email}){
  }

  @override
  void dispose() {
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(LOGIN_BG_PIC),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            ListView(
              children: [
                Container(
                    child: Container(
                      margin: EdgeInsets.only(top: 60),
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        FORGET_PASSWORD_SENTSUCCESSFULLY_PIC,
                        width: 217,
                        height: 196,
                      ),
                    )
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Sent successfully",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 30, left: 24),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                            fontSize: 16.0,
                            color: textColor,
                            fontWeight: FontWeight.w300
                        ),
                        children: <TextSpan>[
                          TextSpan(text: 'An email has been sent to:\n'),
                          TextSpan(
                            text: '$email\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                ),
                Container(
                  margin: EdgeInsets.only(left: 24),
                  child: Text(
                      'Please follow the instructions in the email to repaste the password with in 24 hours.',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: textColor,
                          fontWeight: FontWeight.w300
                      )
                  ),
                ),
                Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: 32),
                    child: ClickCustomButton(
                    label: 'Reset Password${_remainingSeconds>0?"(${_remainingSeconds.toString()}s)":''}',
                        onPressed: forgetPassword,
                      enable: _remainingSeconds != 0 ? false : true,
                    )),
                Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: 16),
                    child: ClickCustomButton(label: "Done",
                      onPressed: () {
                        AppNavigator.getInstance()?.onJumpTo(RouteStatus.login);
                        _timer.cancel();
                      }, style: 1,))
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.seconds;
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  void forgetPassword() async {
    _remainingSeconds = 60;
    setState(() {

    });
    try {
      _timer.cancel();
      _timer = Timer.periodic(Duration(seconds: 1), (_) {
        setState(() {
          if (_remainingSeconds > 0) {
            _remainingSeconds--;
          } else {
            _timer.cancel();
          }
        });
      });
      var result = await LoginDao.forgetPassword(email);
      var resp = result as HttpNetResponse;
      print(result);
      print(resp);

      if (resp.data['code'] == 0) {
        print('sign up success');
      } else {
        print(resp.data['message']);
      }
    } on NeedAuth catch (e) {
      print(e);
    } on HttpNetError catch (e) {
      print(e);
    }
  }

  void transmitted() {
    Navigator.pop(context);
    Navigator.pop(context);
  }
}

