import 'package:usak_seramik_app/Controller/notifiers.dart';
import 'package:usak_seramik_app/Rest/Entity/Product/product_entity.dart';
import 'package:usak_seramik_app/Rest/Model/Request/get_request.dart';
import '../../Model/Response/base_response.dart';
import '../crud_service.dart';

class ProductFeatureService extends CrudService<ProductData> {
  static ProductFeatureService operations() {
    return ProductFeatureService();
  }

  Future<BaseResponse> getProductSurfacesService() async {
    return await getRequest("$apiURL/face-surfaces.php", bearerToken: bearerSessionTokenNotifier.value);
  }
  Future<BaseResponse> getProductGlossesService() async {
    return await getRequest("$apiURL/face-glosses.php", bearerToken: bearerSessionTokenNotifier.value);
  }
  Future<BaseResponse> getProductColorsService() async {
    return await getRequest("$apiURL/face-colors.php", bearerToken: bearerSessionTokenNotifier.value);
  }
  Future<BaseResponse> getProductSizesService() async {
    return await getRequest("$apiURL/face-sizes.php", bearerToken: bearerSessionTokenNotifier.value);
  }
  Future<BaseResponse> getProductUsageAreaService() async {
    return await getRequest("$apiURL/product-usage-areas.php", bearerToken: bearerSessionTokenNotifier.value);
  }
  Future<BaseResponse> getProductTypesService() async {
    return await getRequest("$apiURL/product-types.php", bearerToken: bearerSessionTokenNotifier.value);
  }
}
