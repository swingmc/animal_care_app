import 'package:animalCare/http/core/http_net.dart';
import 'package:animalCare/http/core/http_net_adapter.dart';
import 'package:animalCare/http/request/user_center/get_feedback_req.dart';
import 'package:animalCare/util/const.dart';
export 'package:animalCare/http/request/base_request.dart';
import 'package:animalCare/http/request/animal.dart';
import 'package:animalCare/http/request/animal_post.dart';

class AnimalDao {

  static Future<DataModel<GetPostResult>> getPost() async {
    BaseRequest request;

    request = GetPostRequest();

    HttpNetResponse result = await HttpNet.getInstance()?.fire(request);
    DataModel<GetPostResult> data = DataModel<GetPostResult>(result, GetPostResult());
    return data;
  }

  static Future<ResultPlaceholder> sendPost(int userId, String title, String desc, int graphId) async {

    BaseRequest request;

    request = SendPostRequest();
    request.add("userId", userId);
    request.add("title", title);
    request.add("desc", desc);
    request.add("graphId", graphId);

    HttpNetResponse result = await HttpNet.getInstance()?.fire(request);
    ResultPlaceholder resp = DataModel.handleNullResult(result);
    return resp;
  }

}