import '../../../Controller/notifiers.dart';
import '../../Entity/User/user_entity.dart';
import '../../Model/Request/get_request.dart';
import '../../Model/Response/base_response.dart';
import '../crud_service.dart';

class UserService extends CrudService<UserEntity> {
  static UserService operations() {
    return UserService();
  }

  Future<BaseResponse> getUserById({required int id}) async {
    return await getRequest("$apiURL/null", bearerToken: bearerSessionTokenNotifier.value);
  }
}
