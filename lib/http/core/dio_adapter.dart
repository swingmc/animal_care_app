import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:animalCare/http/core/http_net_adapter.dart';
import 'package:animalCare/http/core/http_net_error.dart';
import 'package:animalCare/http/request/base_request.dart';
import 'package:animalCare/logger/logger.dart';


class DioAdapter extends HttpNetAdapter {
  @override
  Future<HttpNetResponse<T>> send<T>(BaseRequest request) async {
    var response, options = Options(headers: request.header);
    //request.header = await addAppCheckToken(request.header);
    var error;
    request.log_send();
    try {
      if (request.httpMethod() == HTTPMethod.GET) {
        response = await Dio().get(request.url(), options: options);

      } else if (request.httpMethod() == HTTPMethod.POST) {
        response = await Dio()
            .post(request.url(), data: request.params, options: options);

        // printCurl(response, request);
      } else if (request.httpMethod() == HTTPMethod.DELETE) {
        response = await Dio()
            .delete(request.url(), data: request.params, options: options);
      } else if (request.httpMethod() == HTTPMethod.POSTFILE) {
        //logger.info(HTTPMethod.POSTFILE);

        // printCurl(response, request);
        final formData = FormData.fromMap({
          'image': request.params["image"],
        });
        //logger.info("${HTTPMethod.POSTFILE} 2");

        //TODO 和其他http请求不一样 不能用通用逻辑 要注意
        response = await Dio().post(request.url(), data: formData, options: options);
        //logger.info("response: ${response}");
      } else if (request.httpMethod() == HTTPMethod.GETFILE) {
        response = await Dio().get(request.url(), options: Options(
          responseType: ResponseType.bytes,
          followRedirects: true,
          headers: request.header)
        );
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    }
    if (error != null) {
      throw HttpNetError(response?.statusCode ?? -1, error.toString(),
          data: await buildRes(response, request));
    }
    return buildRes(response, request);
  }

  Future<HttpNetResponse<T>> buildRes<T>(
      Response? response, BaseRequest request) {
    HttpNetResponse<T> resp = HttpNetResponse(
      //?.防止response为空
        data: response?.data,
        request: request,
        statuCode: response?.statusCode,
        statusMesssage: response?.statusMessage,
        extra: response);
    resp.checkStatus();
    return Future.value(resp);
  }
}

void printCurl(Response response, BaseRequest request) {
  // Get request details
  RequestOptions options2 = response.requestOptions;

  // Construct curl command
  String curlCommand = 'curl -X ${options2.method} ';

  // Add headers
  options2.headers.forEach((key, value) {
    curlCommand += '-H \'$key: $value\' ';
  });

  // Add request URL
  curlCommand += '\'${options2.uri.toString()}\'';

  // Extract the JSON body
  String requestBody = jsonEncode(request.params);

  // Add JSON body to curl command
  curlCommand += '-d \'$requestBody\' ';

  logger.error(curlCommand);

}

/*
// ttl one hour
Future<Map<String,dynamic>> addAppCheckToken(Map<String,dynamic> headers) async {
  final token = await FirebaseAppCheck.instance.getToken();
  headers['AppCheckToken'] = token;
  return headers;
}

 */