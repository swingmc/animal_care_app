import 'package:animalCare/http/core/dio_adapter.dart';
import 'package:animalCare/http/core/http_net_adapter.dart';
import 'package:animalCare/http/core/http_net_error.dart';
import 'package:animalCare/http/request/base_request.dart';
import 'package:animalCare/db/local_cache.dart';
import 'package:animalCare/util/const.dart';
import 'dart:io';
import 'package:animalCare/logger/logger.dart';

class HttpNet {
  HttpNet._();
  static HttpNet? _instance = HttpNet._();
  static HttpNet? getInstance() {
    return _instance;
  }

  Future fire(BaseRequest request) async {
    HttpNetResponse? response;
    if(request.needLogin()){
      LocalCache.preInit();
      request.addHeader("Cookie", "token=" + LocalCache.getInstance()
          .get(TOKEN_KEY));
      // request.addHeader("Content-Type", "application/json");
      print("header: " + request.header.toString());
    }

    //给请求打标
    request.addHeader("serial_id", request.serializeId);

    var error;
    try {
      response = await send(request);
    } on HttpNetError catch(e) {
      error = e;
      response = e.data;
      printLog(e.message);
    } catch(e) {
      //other exception
      error = e;
      printLog(e);
    }

    if (response == null) {
      printLog(error);
    }

    var result = response?.data;
    printLog(request);

    var status = response?.statuCode;
    switch(status) {
      case 200:
        return response;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(), data:  result);
      default:
        logger.error("status: ${status}, result: ${result.toString()}");
        throw HttpNetError(status!, result.toString(), data: result);
    }
  }

  Future<dynamic> send<T>(BaseRequest request) async {
    printLog('url:${request.url()}');


    HttpNetAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  void printLog(log) {
    print('net:${log.toString()}');
  }
}