import 'package:usak_seramik_app/Rest/Entity/Dealer/dealer_filter_entity.dart';
import 'package:usak_seramik_app/Rest/Entity/User/contact_entity.dart';
import 'package:usak_seramik_app/Rest/Entity/Dealer/dealer_entity.dart';
import '../../../Controller/notifiers.dart';
import '../../Model/Request/get_request.dart';
import '../../Model/Request/post_request.dart';
import '../../Model/Response/base_response.dart';
import '../crud_service.dart';

class DealerService extends CrudService<DealerData> {
  static DealerService operations() {
    return DealerService();
  }

  Future<BaseResponse> getDealerService(DealerFilterEntity dealerFilterEntity) async {
    return await multiPartPostDataRequest(
      "$apiURL/dealers.php",
      bearerToken: bearerSessionTokenNotifier.value,
      entityData: dealerFilterEntity,
    );
  }
}
