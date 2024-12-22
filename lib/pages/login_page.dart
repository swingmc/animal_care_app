import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:animalCare/http/core/http_net_adapter.dart';
import 'package:animalCare/http/core/http_net_error.dart';
import 'package:animalCare/http/dao/login_dao.dart';
import 'package:animalCare/navigator/app_navigator.dart';
import 'package:animalCare/widget/login_input.dart';
import 'package:animalCare/widget/general_button.dart';
import 'package:animalCare/db/local_cache.dart';
import 'package:animalCare/util/export_file.dart';
import 'package:animalCare/logger/logger.dart';
import 'package:animalCare/widget/pop_toast.dart';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import '../util/text.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key}){}
  @override
  State<StatefulWidget> createState() => _LoginPageState();
  
}

class _LoginPageState extends State<LoginPage> {

  bool loginEnable = false;
  String userName = "";
  String password = "";
  String rePassword = "";
  String email = "";
  String nickName = "";

  int? id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
          canPop:false,
          child: Container(
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
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                        height: 200,
                        alignment: Alignment.center,
                        child: SizedBox(
                            width: 120,
                            height: 120,
                            child: Container(
                              width: 3,
                              height: 3,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  alignment: Alignment.center,
                                  image: AssetImage(APP_LOGO),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                        )),
                    LoginInput(
                      Image.asset(USERNAME_ICON), "Email",
                      onChanged: (String s) {
                        userName = s;
                      },
                      // errNotice: "* Username/Email error",
                      // validate: () {
                      //   var input = userName.isEmpty || userName.length >= 3;
                      //   return input;
                      // },
                      buttonImagePath: CLOSE_ICON,
                      rightButtonCallback: CleanUpContent,
                    ),
                    LoginInput(
                      Image.asset(USERNAME_ICON), "Password",
                      onChanged: (String s) {
                        password = s;
                      },
                      // errNotice: "* Username/Email error",
                      // validate: () {
                      //   var input = userName.isEmpty || userName.length >= 3;
                      //   return input;
                      // },
                      buttonImagePath: EYES_ICON,
                      rightButtonCallback: CleanUpContent,
                    ),

                    Container(
                        margin: EdgeInsets.only(top: 32),
                        child: ClickCustomButton(label: "sign in", onPressed: login)
                    ),
                    Column(
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(top: 20, left: 24),
                            child: textTag01("Don't have an account?")
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(top: 8, left: 24),
                            child: RichText(text: TextSpan(
                                text: "Sign up",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: buttonTagColor
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {

                                  }
                            ))
                        ),
                        Container(height: 16,),


                        //bug解完再上线
                        //Divider
                        // WrapWithSymetricBorder(
                        //     Row(
                        //       children: [
                        //         Expanded(
                        //             flex: 2,
                        //                 child: Divider(
                        //           color: Colors.grey,
                        //           thickness: 0.5, // Adjust the thickness of the line
                        //         )),
                        //         Expanded(
                        //             flex: 1,child: Container(
                        //             alignment: Alignment.center,
                        //             child: textTag02("Or"))),
                        //         Expanded(
                        //             flex: 2,
                        //
                        //                 child: Divider(
                        //           color: Colors.grey,
                        //           thickness: 0.5, // Adjust the thickness of the line
                        //         )),
                        //       ],
                        //     ),
                        //     mid: 15),

                        // FirebaseLoginWidget(),


                      ],
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  void login() async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    LocalCache.preInit();
    List<String> cookies = [];
    try {
      //var result = await LoginDao.login(userName, password);






          logger.error("cookie is not empty");
          String token = "AtestToken";
          LocalCache cache = LocalCache.getInstance();
          logger.error(cache);
          var result = cache.setString(TOKEN_KEY, token);
          //logger.error(result);
          //sleep(Duration(seconds: 5));

        AppNavigator.getInstance()?.onJumpTo(RouteStatus.home);
        CustomToast.showToast(context, "login success");

    } on NeedAuth catch (e) {
      print(e);
    } on HttpNetError catch (e) {
      print(e);
    }

    //write token to shared preferrence
    LocalCache cache = LocalCache.getInstance();

    if (!cookies.isEmpty) {
    List<String> values = cookies[0].split('; ');
    String token = values[0].split('=')[1];
    cache.setString(TOKEN_KEY, token);
    }

    print(cache.get(TOKEN_KEY));
  }

  void register() async {
    LocalCache.preInit();
    List<String> cookies = [];
    try {
      var result = await LoginDao.registration(email, password);
      var resp = result as HttpNetResponse;
      cookies = (resp.extra as Response).headers["set-cookie"] as List<String>;
      print(cookies);

      if (resp.data['code'] == '0') {
        print('sign up success');
      } else {
        print(resp.data['msg']);
      }
    } on NeedAuth catch (e) {
      print(e);
    } on HttpNetError catch (e) {
      print(e);
    }

    //write token to shared preferrence
    LocalCache cache = LocalCache.getInstance();

    if (!cookies.isEmpty) {
      List<String> values = cookies[0].split('; ');
      String token = values[0].split('=')[1];
      cache.setString(TOKEN_KEY, token);
    }

    logger.error("user token: ${cache.get(TOKEN_KEY)}");
  }
}
