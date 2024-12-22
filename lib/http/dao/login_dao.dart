import 'dart:io';

import 'package:animalCare/db/local_cache.dart';
import 'package:animalCare/http/core/http_net.dart';
import 'package:animalCare/http/core/http_net_adapter.dart';
import 'package:animalCare/http/request/base_request.dart';
import 'package:animalCare/http/request/email_check_status_request.dart';
import 'package:animalCare/http/request/login_request.dart';
import 'package:animalCare/http/request/forget_password_request.dart';
import 'package:animalCare/http/request/send_email_request.dart';
import 'package:animalCare/util/const.dart';
import 'package:animalCare/main.dart';

class LoginDao {
  static login(String email, String password) {
    return _send(emailNum: email, password: password);
  }

  static registration(String emailNum, String password) {
    return _send(emailNum: emailNum, password: password, isSignUp: true);
  }

  static forgetPassword(String email) {
    return _send(emailNum: email);
  }

  static _send({String? password, String? emailNum, bool isSignUp = false}) async {
    BaseRequest request;
   if (emailNum != null && password == null) {
      request = ForgetPasswordRequest();
    } else {
      request = LoginRequest();
      var brand = "";
      if (Platform.isAndroid) {
        brand = "android";
      } else if (Platform.isIOS) {
        brand = "iphone";
      }
      
      request.addPathParams("brand", brand)
          .addPathParams("phone_id", FCM_TOKEN);
    }

    request.add("email", emailNum)
        .add("password", password)
        .add("phone_id", FCM_TOKEN);

    print(request.params);

    var result = await HttpNet.getInstance()?.fire(request);
    print(result);
    return result;
  }

  static getLoginState() {
    return LocalCache.getInstance().get(TOKEN_KEY);
  }

  static sendEmail(String email, String password) async {
    BaseRequest request;
    request = SendEmailRequest();
    
    request.add("email", email)
        .add("password", password);

    HttpNetResponse result = await HttpNet.getInstance()?.fire(request);
    return result;
  }

  static checkEmailStatus(String email) async {
    BaseRequest request;
    request = EmailCheckStatusRequest();

    request.addPathParams("email", email);

    HttpNetResponse result = await HttpNet.getInstance()?.fire(request);
    ResultPlaceholder resp = DataModel.handleNullResult(result);
    return resp;
  }
}