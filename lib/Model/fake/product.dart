import 'package:usak_seramik_app/Controller/asset.dart';

class Product {
  late int id;
  late String name;
  late String description;
  late String image;
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });
}

List<Product> productList = [
  Product(id: 0, name: "madrid", description: "Mükemmeliğin küçük ayrıntılarda gizlendiği bir doku", image: AppDummy.madrid),
  Product(id: 1, name: "calcare", description: "Ekvatoral sıcaklığın, huzur ve sağlığın tasarımıyla tanışın", image: AppDummy.calcare),
  Product(id: 2, name: "ada", description: "Huzur ve sağlığın tasarımıyla tanışın", image: AppDummy.ada),
];
