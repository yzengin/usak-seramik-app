import 'package:usak_seramik_app/Rest/Entity/Dealer/dealer_entity.dart';
import '../../../Controller/notifiers.dart';
import '../../Model/Request/post_request.dart';
import '../../Model/Response/base_response.dart';
import '../crud_service.dart';

class DealerService extends CrudService<DealerData> {
  static DealerService operations() {
    return DealerService();
  }

  Future<BaseResponse> getDealerService(DealerFilterEntity dealerFilterEntity) async {
    return await postRequest("$apiURL/dealers.php",
      entityData: dealerFilterEntity,
      bearerToken: bearerSessionTokenNotifier.value,
    );
  }
}
