import '../Entity/persistent.dart';

abstract class CrudService<T extends Persistent> {
  String apiURL = "https://www.usakseramik.com/api";
  String hostName = "null";
}
