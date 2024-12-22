import 'package:animalCare/http/core/http_net_adapter.dart';
import 'package:animalCare/http/request/base_request.dart';

///测试适配器，mock数据
class MockAdapter extends HttpNetAdapter {
  @override
  Future<HttpNetResponse<T>> send<T>(BaseRequest request) {
    return Future.delayed(Duration(milliseconds: 1000), () {
      return HttpNetResponse(
        data: {"code": 0, "message": 'success'} as T, statuCode: 403);
    });
  }
}