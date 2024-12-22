import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:animalCare/http/core/http_net.dart';
import 'package:animalCare/http/core/http_net_adapter.dart';
import 'package:animalCare/http/request/base_request.dart';
import 'package:animalCare/http/request/home_page/upload_app_info_request.dart';
import 'package:animalCare/http/request/user_center/close_account_req.dart';
import 'package:animalCare/http/request/user_center/contribute_requset.dart';
import 'package:animalCare/http/request/user_center/get_feedback_req.dart';
import 'package:animalCare/http/request/user_center/get_user_info_req.dart';
import 'package:animalCare/main.dart';
export 'package:animalCare/http/request/user_center/get_feedback_req.dart';


class UserCenterDao {

  static Future<DataModel<GetUserInfoResult>> get_user_info() async {
    BaseRequest request;

    request = GetUserInfoRequest();

    request.addPathParams("phone_id", FCM_TOKEN);

    HttpNetResponse result = await HttpNet.getInstance()?.fire(request);
    DataModel<GetUserInfoResult> data = DataModel<GetUserInfoResult>(result, GetUserInfoResult());
    return data;
  }


  static Future<ResultPlaceholder> change_password(String oldPassword, String newPassword) async {
    BaseRequest request;

    request = ChangePasswordRequest();
    request = request.add("old_password", oldPassword)
        .add("new_password", newPassword);

    HttpNetResponse result = await HttpNet.getInstance()?.fire(request);
    ResultPlaceholder resp = DataModel.handleNullResult(result);
    return resp;
  }

  static Future<DataModel<UploadImageResult>> uploadImage(MultipartFile image) async {
    BaseRequest request;

    request = UploadImageRequest();
    request = request.add("image", image);

    HttpNetResponse result = await HttpNet.getInstance()?.fire(request);
    DataModel<UploadImageResult> data = DataModel<UploadImageResult>(result, UploadImageResult());
    return data;
  }

  static Future<Uint8List> getImage(int imageid) async {
    BaseRequest request;

    request = GetImageRequest(imageid);

    HttpNetResponse response = await HttpNet.getInstance()?.fire(request);
    return response.data;
  }

  static Future<ResultPlaceholder> closeAccount() async {
    BaseRequest request;

    request = CloseAccountRequest();

    HttpNetResponse result = await HttpNet.getInstance()?.fire(request);
    ResultPlaceholder resp = DataModel.handleNullResult(result);
    return resp;
  }
}