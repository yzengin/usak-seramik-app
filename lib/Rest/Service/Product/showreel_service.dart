import 'package:usak_seramik_app/Rest/Entity/Product/product_entity.dart';
import 'package:usak_seramik_app/Rest/Entity/Product/showreel_entity.dart';
import '../../Model/Request/post_request.dart';
import '../../Model/Response/base_response.dart';
import '../crud_service.dart';

class ShowreelService extends CrudService<ShowreelData> {
  static ShowreelService operations() {
    return ShowreelService();
  }

  Future<BaseResponse> getShowreelService() async {
    return await postRequest("$apiURL/sliders.php");
  }
}
