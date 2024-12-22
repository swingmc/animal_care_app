import 'dart:convert';
import 'package:animalCare/logger/logger.dart';
import 'package:animalCare/http/request/base_request.dart';

abstract class HttpNetAdapter {
  Future<HttpNetResponse<T>> send<T>(BaseRequest request);
}


class HttpNetResponse<T> {
  T? data;
  BaseRequest? request;
  int? statuCode;
  String? statusMesssage;
  dynamic extra;
  DateTime receiveTime = DateTime.now();

  HttpNetResponse({this.data, this.request, this.statuCode
    , this.statusMesssage, this.extra});

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }

  void checkStatus(){
    _log_receive();
    if(statuCode != 200) {
      _log_warning();
    }
  }

  void _log_receive(){
    logger.debug(StringBuffer([
      "id: ",
      request?.serializeId,
      ", url: ",
      request?.url(),
      ", code: ",
      statuCode,
      ", start_time: ",
      request?.startTime.toString(),
      ", receive_time: ",
      receiveTime.toString(),
      ", message: ",
      statusMesssage,
      ", usehttps: ",
      request?.useHttps,
    ]).toString());
  }

  void _log_warning(){
    logger.warning(StringBuffer([
      "id: ",
      request?.serializeId,
      ", url: ",
      request?.url(),
      ", code: ",
      statuCode,
      ", start_time: ",
      request?.startTime.toString(),
      ", receive_time: ",
      receiveTime.toString(),
      ", message: ",
      statusMesssage,
      ", usehttps: ",
      request?.useHttps,
    ]).toString());
  }
}