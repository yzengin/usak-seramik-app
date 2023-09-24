import 'package:usak_seramik_app/Controller/notifiers.dart';
import 'package:usak_seramik_app/Rest/Controller/Product/product_controller.dart';
import 'package:usak_seramik_app/Rest/Entity/Product/product_entity.dart';
import '../../Model/Request/post_request.dart';
import '../../Model/Response/base_response.dart';
import '../crud_service.dart';

class ProductService extends CrudService<ProductData> {
  static ProductService operations() {
    return ProductService();
  }

  Future<BaseResponse> getProductFilterService(ProductAttributesSearch productAttributesSearch, {int page = 0, int size = 20}) async {
    return await postRequest("$apiURL/v1/products.php?page=$page&size=$size", entityData: productAttributesSearch, bearerToken: bearerSessionTokenNotifier.value);
  }
  Future<BaseResponse> getProductByIdService(int id) async {
    return await postRequest("$apiURL/product-detail.php?product_id=$id", bearerToken: bearerSessionTokenNotifier.value);
  }
}
