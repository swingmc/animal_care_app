
import 'package:animalCare/logger/logger.dart';
import 'package:uuid/uuid.dart';
import 'package:animalCare/http/core/http_net_adapter.dart';

import 'package:animalCare/util/debug_env.dart';

export 'package:json_annotation/json_annotation.dart';
//part 'base_request.g.dart';

Uuid uuid = Uuid();

enum HTTPMethod { GET, POST , DELETE , POSTFILE, GETFILE}
/// 基础请求类型

abstract class BaseRequest {
  Map<String, dynamic> pathParams = Map();
  var useHttps = GetUseHTTPS();
  DateTime startTime = DateTime.now();
  String serializeId = uuid.v1();
  //List<Cookie>? cookies;
  String authority() {
    return GetCurrentServerDomain();
  }
  HTTPMethod httpMethod();
  String path();
  String url()  {
    Uri uri;
    var pathStr = path();
    //拼接path
    /*
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }

     */

    ///http or https
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, pathParams);
    } else {
      uri = Uri.http(authority(), pathStr, pathParams);
    }
    return uri.toString();
  }

  ///需要登陆接口
  bool needLogin();

  ///添加参数
  Map<String, dynamic> params = Map();
  BaseRequest add(String k, Object? v) {
    if (v == null) {
      return this;
    }
    params[k] = v;
    return this;
  }

  BaseRequest addPathParams(String k, Object? v) {
    if (v == null) {
      return this;
    }
    pathParams[k] = v.toString();
    return this;
  }

  BaseRequest addListPathParams(String k, Object? v) {
    if (v == null) {
      return this;
    }
    pathParams[k] = v;
    return this;
  }

  /*
  ///添加参数到body
  Map<String, String> bodyParams = Map();
  BaseRequest addBodyParam(String k, Object? v) {
    if (v == null) {
      return this;
    }
    params[k] = v.toString();
    return this;
  }
   */

  ///添加header
  Map<String, dynamic> header = Map();
  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }

  void log_send(){
    logger.info(StringBuffer([
      "id: ",
      serializeId,
      ", url: ",
      url(),
      ", start_time: ",
      startTime,
      ", usehttps: ",
      useHttps,
      "params: ",
      params
    ]).toString());
  }
}

class Jsonable {
  //Map<String, dynamic> toJson();
  Jsonable fromJson(Map<String, dynamic> json){
    throw Exception("unimplemented");
    return Jsonable();
  }
}

class ResultPlaceholder {
  String code;
  String message;
  ResultPlaceholder(this.code, this.message);
}

class DataModel<T extends Jsonable>{

  T? data;

  DataModel(HttpNetResponse response, T obj){
    data = obj;
    checkStatus(response);
    logger.info(response.data["result"]);
    this.data = data?.fromJson(response.data["result"]) as T;
  }

  static checkStatus(HttpNetResponse response) {
    String code = response.data["code"];
    String message = response.data["message"];
    if(code != "0"){
      logger.warning(code+":"+message);
    }
  }

  static ResultPlaceholder handleNullResult(HttpNetResponse response) {
    checkStatus(response);
    return ResultPlaceholder(response.data["code"], response.data["message"]);
  }
}

