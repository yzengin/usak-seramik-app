import '/Controller/notifiers.dart';

import '../../Entity/Auth/login_entity.dart';
import '../../Entity/Auth/register_entity.dart';
import '../../Model/Request/post_request.dart';
import '../../Model/Response/base_response.dart';
import '../crud_service.dart';

class AuthenticationService extends CrudService<LoginEntity> {
  static AuthenticationService operations() {
    return AuthenticationService();
  }

  Future<BaseResponse> login({required LoginEntity loginEntity}) async {
    return await postRequest("$apiURL/login", entityData: loginEntity, bearerToken: bearerSessionTokenNotifier.value);
  }

  Future<BaseResponse> register({required RegisterEntity registerEntity}) async {
    return await postRequest("$apiURL/kayitol", entityData: registerEntity, bearerToken: bearerSessionTokenNotifier.value);
  }
}
