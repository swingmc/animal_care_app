import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animalCare/http/request/user_center/get_feedback_req.dart';
import 'package:animalCare/logger/logger.dart';
import 'package:animalCare/http/dao/user_center_dao.dart';
import 'package:animalCare/util/const.dart';
import 'package:animalCare/util/data_isolation.dart';
import 'package:animalCare/http/request/base_request.dart';
import 'package:animalCare/db/local_cache.dart';
import 'dart:typed_data';
import 'package:animalCare/util/export_file.dart';


class MyDataProvider extends ChangeNotifier {
  bool isReady = false;
  GetUserInfoResult? userInfo;
  Image? avatar;
  String? avatarLocalPath;
  String? appTargetVersion;

  Future<void> fetchData() async {
    LocalCache.preInit();
    fetchUserInfo();
    isReady = true;
  }


  fetchUserInfo() async {
    DataModel<GetUserInfoResult> userInfo = await UserCenterDao.get_user_info();
    this.userInfo = userInfo.data;

    try {
      LocalCache.getInstance().setInt(USER_ID, userInfo.data?.user_id ?? -1);
      avatar = await readLocalUserAvatar(userInfo.data?.avatar_image_id??0);
      avatarLocalPath = await getLocalAvatarPath(userInfo.data?.avatar_image_id??0);
      if(avatar == null){
        Uint8List data = await UserCenterDao.getImage(userInfo.data?.avatar_image_id??0);
        Image avatar = Image.memory(data);
        this.avatar = avatar;
        saveUserAvatar(userInfo.data?.avatar_image_id ?? 0, data);
            }
    } catch(e){
      logger.error(e);
    }
  }


  Future<dynamic> refreshUserData() async {
    await fetchUserInfo();
    notifyListeners();
  }
}
