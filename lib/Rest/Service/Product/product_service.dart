import 'package:usak_seramik_app/Controller/notifiers.dart';
import 'package:usak_seramik_app/Rest/Entity/Product/product_entity.dart';
import '../../Model/Request/post_request.dart';
import '../../Model/Response/base_response.dart';
import '../crud_service.dart';

class ProductService extends CrudService<ProductData> {
  static ProductService operations() {
    return ProductService();
  }

  Future<BaseResponse> getProductService({int page = 0, int size = 10}) async {
    return await postRequest("$apiURL/products.php?page=$page&size=$size", bearerToken: bearerSessionTokenNotifier.value);
  }
}
