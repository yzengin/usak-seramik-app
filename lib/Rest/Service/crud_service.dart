import '../Entity/persistent.dart';

abstract class CrudService<T extends Persistent> {
  String apiURL = "null";
  String hostName = "null";
}
