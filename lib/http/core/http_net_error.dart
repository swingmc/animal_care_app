
class NeedLogin extends HttpNetError {
  NeedLogin({int code = 401, String message: 'need login'})
      : super(code, message);
}

class NeedAuth extends HttpNetError {
  NeedAuth(String message, {int code = 403, dynamic data})
      : super(code, message, data: data);
}


class HttpNetError implements Exception {
  final int code;
  final String message;
  final dynamic data;

  HttpNetError(this.code, this.message, {this.data});
}