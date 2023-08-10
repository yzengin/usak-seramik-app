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

List<Product> showreelList = [
  Product(id: 0, name: "madrid", description: "Mükemmeliğin küçük ayrıntılarda gizlendiği bir doku", image: AppDummy.madrid),
  Product(id: 1, name: "calcare", description: "Ekvatoral sıcaklığın, huzur ve sağlığın tasarımıyla tanışın", image: AppDummy.calcare),
  Product(id: 2, name: "ada", description: "Huzur ve sağlığın tasarımıyla tanışın", image: AppDummy.ada),
];

List<Product> productList = [
  Product(id: 0, name: "ada", description: "Mükemmeliğin küçük ayrıntılarda gizlendiği bir doku", image: AppDummy.ada),
  Product(id: 1, name: "aged", description: "Ekvatoral sıcaklığın, huzur ve sağlığın tasarımıyla tanışın", image: AppDummy.aged),
  Product(id: 2, name: "agewood", description: "Huzur ve sağlığın tasarımıyla tanışın", image: AppDummy.agewood),
  Product(id: 3, name: "akasya", description: "Huzur ve sağlığın tasarımıyla tanışın", image: AppDummy.akasya),
  Product(id: 4, name: "agewood", description: "Huzur ve sağlığın tasarımıyla tanışın", image: AppDummy.alanya),
  Product(id: 5, name: "agewood", description: "Huzur ve sağlığın tasarımıyla tanışın", image: AppDummy.alara),
  Product(id: 6, name: "agewood", description: "Huzur ve sağlığın tasarımıyla tanışın", image: AppDummy.alice),
  Product(id: 7, name: "agewood", description: "Huzur ve sağlığın tasarımıyla tanışın", image: AppDummy.alpina),
  Product(id: 8, name: "agewood", description: "Huzur ve sağlığın tasarımıyla tanışın", image: AppDummy.anadolu),
  Product(id: 9, name: "agewood", description: "Huzur ve sağlığın tasarımıyla tanışın", image: AppDummy.angela),
  Product(id: 10, name: "agewood", description: "Huzur ve sağlığın tasarımıyla tanışın", image: AppDummy.antik),
  Product(id: 11, name: "agewood", description: "Huzur ve sağlığın tasarımıyla tanışın", image: AppDummy.antiquewood),
  Product(id: 12, name: "agewood", description: "Huzur ve sağlığın tasarımıyla tanışın", image: AppDummy.aragon),
  Product(id: 13, name: "agewood", description: "Huzur ve sağlığın tasarımıyla tanışın", image: AppDummy.arc),
  Product(id: 14, name: "agewood", description: "Huzur ve sağlığın tasarımıyla tanışın", image: AppDummy.arden),
  Product(id: 15, name: "agewood", description: "Huzur ve sağlığın tasarımıyla tanışın", image: AppDummy.ariman),
  Product(id: 16, name: "agewood", description: "Huzur ve sağlığın tasarımıyla tanışın", image: AppDummy.arin),
  Product(id: 17, name: "agewood", description: "Huzur ve sağlığın tasarımıyla tanışın", image: AppDummy.arizona),
  Product(id: 18, name: "agewood", description: "Huzur ve sağlığın tasarımıyla tanışın", image: AppDummy.armattura),
  Product(id: 19, name: "agewood", description: "Huzur ve sağlığın tasarımıyla tanışın", image: AppDummy.arya),
  Product(id: 20, name: "agewood", description: "Huzur ve sağlığın tasarımıyla tanışın", image: AppDummy.asos),
  Product(id: 21, name: "agewood", description: "Huzur ve sağlığın tasarımıyla tanışın", image: AppDummy.calcare),
  Product(id: 22, name: "agewood", description: "Huzur ve sağlığın tasarımıyla tanışın", image: AppDummy.madrid),
];
