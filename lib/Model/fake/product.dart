import 'package:flutter/material.dart';
import 'package:usak_seramik_app/View/style/colors.dart';

class Product {
  late int id;
  late String title;
  late String description;
  late String image;
  late List<Face>? face;
  late List<Color> color;
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    this.face,
    required this.color,
  });
}

class Face {
  late int id;
  late String title;
  late String image;
  late String size;
  late List<String> properties;
  Face({
    required this.id,
    required this.title,
    required this.image,
    required this.properties,
    required this.size,
  });
}

List<Product> showreelList = [
  productList[0],
  productList[7],
  productList[8],
];

List<Product> productList = [
  Product(
    id: 0,
    title: "ada",
    description: "Huzur ve sağlığın tasarımıyla tanışın",
    image: "https://usakseramik.com/storage/1099/15740-ada-mekan-gorseli.jpg",
    face: [
      Face(id: 0, title: 'Ada Bone', image: "https://usakseramik.com/storage/375/ADA-BONE-F1-T3.jpg", properties: ['FL'], size: "60x120"),
      Face(id: 1, title: 'Ada Kahve', image: "https://usakseramik.com/storage/374/ADA-DARK-BROWN-F1.jpg", properties: ['FL'], size: "60x120"),
    ],
    color: [
      AppColors.filter3,
    ],
  ),
  Product(
    id: 1,
    title: "aged",
    description: "",
    image: "https://usakseramik.com/storage/1088/15738-aged-mekan-gorseli.jpg",
    face: [
      Face(id: 0, title: 'Aged', image: "https://usakseramik.com/storage/1089/2653-aged-aged-face-gorseli.jpg", properties: ['FL'], size: "60x120")
    ],
    color: [
      AppColors.filter4,
      AppColors.filter3,
    ],
  ),
  Product(
    id: 2,
    title: "agewood",
    description: "",
    image: "https://usakseramik.com/storage/866/15696-agewood-mekan-gorseli.jpg",
    face: [
      Face(id: 0, title: 'Agewood', image: "https://usakseramik.com/storage/866/15696-agewood-mekan-gorseli.jpg", properties: ["M"], size: "20.5x60")
    ],
    color: [
      AppColors.filter4,
    ],
  ),
  Product(
    id: 3,
    title: "akasya",
    description: "",
    image: "https://usakseramik.com/storage/757/15671-akasya-mekan-gorseli.jpg",
    face: [
      Face(id: 0, title: 'Akasya Gri', image: "https://usakseramik.com/storage/757/15671-akasya-mekan-gorseli.jpg", properties: ["S"], size: "45x45"),
    ],
    color: [
      AppColors.filter4,
      AppColors.filter5,
    ],
  ),
  Product(
    id: 4,
    title: "alanya",
    description: "",
    image: "https://usakseramik.com/storage/281/15634-alanya-mekan-gorseli.jpg",
    face: [
      Face(id: 0, title: 'Alanya Kahve', image: "https://usakseramik.com/storage/534/conversions/2621-alanya-alanya-kahve-face-gorseli-thumb.jpg", properties: ["M", "FL"], size: "60x120"),
      Face(id: 1, title: 'Alanya Gri', image: "https://usakseramik.com/storage/544/conversions/2622-alanya-alanya-gri-face-gorseli-thumb.jpg", properties: ["M", "FL"], size: "60x120"),
      Face(id: 2, title: 'Alanya Antrasit', image: "https://usakseramik.com/storage/535/conversions/2623-alanya-alanya-antrasit-face-gorseli-thumb.jpg", properties: ["M, FL"], size: "60x120"),
      Face(id: 3, title: 'Alanya Bej', image: "https://usakseramik.com/storage/542/conversions/2624-alanya-alanya-bej-face-gorseli-thumb.jpg", properties: ["M", "FL"], size: "60x120"),
      Face(id: 4, title: 'Alanya Kahve', image: "https://usakseramik.com/storage/536/conversions/2537-alanya-alanya-kahve-face-gorseli-thumb.jpg", properties: ["M", "FL"], size: "60x60"),
      Face(id: 5, title: 'Alanya Gri', image: "https://usakseramik.com/storage/547/conversions/2609-alanya-alanya-gri-face-gorseli-thumb.jpg", properties: ["M", "FL"], size: "60x60"),
      Face(id: 6, title: 'Alanya Antrasit', image: "https://usakseramik.com/storage/546/conversions/2610-alanya-alanya-antrasit-face-gorseli-thumb.jpg", properties: ["M, FL"], size: "60x60"),
      Face(id: 7, title: 'Alanya Bej', image: "https://usakseramik.com/storage/545/conversions/2611-alanya-alanya-bej-face-gorseli-thumb.jpg", properties: ["M", "FL"], size: "60x60"),
      Face(id: 8, title: 'Alanya Antrasit', image: "https://usakseramik.com/storage/530/conversions/2306-alanya-alanya-antrasit-face-gorseli-thumb.jpg", properties: ["M", "FL"], size: "30x80"),
      Face(id: 9, title: 'Alanya Elit Dekor', image: "https://usakseramik.com/storage/538/conversions/2309-alanya-alanya-elit-dekor-face-gorseli-thumb.jpg", properties: ["M", "FL"], size: "30x80"),
      Face(id: 10, title: 'Alanya Multi Dekor', image: "https://usakseramik.com/storage/545/conversions/2611-alanya-alanya-bej-face-gorseli-thumb.jpg", properties: ["M", "FL"], size: "30x80"),
      Face(id: 11, title: 'Alanya Bone', image: "https://usakseramik.com/storage/545/conversions/2611-alanya-alanya-bej-face-gorseli-thumb.jpg", properties: ["M", "FL"], size: "30x80"),
      Face(id: 12, title: 'Alanya Kahve', image: "https://usakseramik.com/storage/545/conversions/2611-alanya-alanya-bej-face-gorseli-thumb.jpg", properties: ["M", "FL"], size: "30x80"),
      Face(id: 13, title: 'Alanya Bone', image: "https://usakseramik.com/storage/545/conversions/2611-alanya-alanya-bej-face-gorseli-thumb.jpg", properties: ["M", "FL"], size: "48x48"),
      Face(id: 14, title: 'Alanya Kahve', image: "https://usakseramik.com/storage/545/conversions/2611-alanya-alanya-bej-face-gorseli-thumb.jpg", properties: ["M", "FL"], size: "30x60"),
      Face(id: 15, title: 'Alanya Gri', image: "https://usakseramik.com/storage/545/conversions/2611-alanya-alanya-bej-face-gorseli-thumb.jpg", properties: ["M", "FL"], size: "30x60"),
      Face(id: 16, title: 'Alanya Bone', image: "https://usakseramik.com/storage/545/conversions/2611-alanya-alanya-bej-face-gorseli-thumb.jpg", properties: ["M", "FL"], size: "30x60"),
      Face(id: 17, title: 'Alanya Antrasit', image: "https://usakseramik.com/storage/545/conversions/2611-alanya-alanya-bej-face-gorseli-thumb.jpg", properties: ["M", "FL"], size: "30x60"),
    ],
    color: [
      AppColors.filter3,
      AppColors.filter4,
      AppColors.filter2,
      AppColors.filter5,
      AppColors.filter6,
      AppColors.filter9,
    ],
  ),
  Product(
    id: 5,
    title: "alara",
    description: "",
    image: "https://usakseramik.com/storage/259/15619-alara-mekan-gorseli.jpg",
    face: [
      Face(id: 0, title: 'Alara', image: "https://usakseramik.com/storage/430/conversions/2251-alara-alara-face-gorseli-thumb.jpg", properties: ['S'], size: '48x48'),
      Face(id: 0, title: 'Alara', image: "https://usakseramik.com/storage/389/conversions/2249-alara-alara-face-gorseli-thumb.jpg", properties: ['S'], size: '30x60'),
      Face(id: 0, title: 'Alara', image: "https://usakseramik.com/storage/390/conversions/2250-alara-alara-dekor-face-gorseli-thumb.jpg", properties: ['S'], size: '30x60'),
    ],
    color: [
      AppColors.filter10,
      AppColors.filter8,
    ],
  ),
  Product(
    id: 6,
    title: "alice",
    description: "",
    image: "https://usakseramik.com/storage/261/15620-alice-mekan-gorseli.jpg",
    face: [
      Face(id: 0, title: 'Alice Beyaz', image: "https://usakseramik.com/storage/443/conversions/2257-alice-alice-beyaz-face-gorseli-thumb.jpg", properties: ['S'], size: '48x48'),
      Face(id: 1, title: 'Alice Beyaz', image: "https://usakseramik.com/storage/434/conversions/2252-alice-alice-beyaz-face-gorseli-thumb.jpg", properties: ['S'], size: '30x60'),
      Face(id: 2, title: 'Alice Antrasit', image: "https://usakseramik.com/storage/438/conversions/2253-alice-alice-antrasit-face-gorseli-thumb.jpg", properties: ['S'], size: '30x60'),
      Face(id: 3, title: 'Alice Kahve', image: "https://usakseramik.com/storage/453/conversions/2254-alice-alice-kahve-face-gorseli-thumb.jpg", properties: ['S'], size: '30x60'),
      Face(id: 6, title: 'Alice Antrasit Dekor', image: "https://usakseramik.com/storage/442/conversions/2256-alice-alice-antrasit-dekor-face-gorseli-thumb.jpg", properties: ['S'], size: '30x60'),
    ],
    color: [
      AppColors.filter10,
      AppColors.filter2,
      AppColors.filter3,
      AppColors.filter9,
    ],
  ),
  Product(
    id: 7,
    title: "calcare",
    description: "Ekvatoral sıcaklığın, huzur ve sağlığın tasarımıyla tanışın",
    image: "https://usakseramik.com/storage/1090/15739-calcare-mekan-gorseli.jpg",
    face: [
      Face(id: 0, title: 'Calcare', image: "https://usakseramik.com/storage/1091/conversions/2654-calcare-calcare-face-gorseli-thumb.jpg", properties: ['FL'], size: '60x120'),
    ],
    color: [
      AppColors.filter4,
    ],
  ),
  Product(
    id: 8,
    title: "madrid",
    description: "Mükemmeliğin küçük ayrıntılarda gizlendiği bir doku",
    image: "https://usakseramik.com/storage/283/15635-madrid-mekan-gorseli.jpg",
    face: [
      Face(id: 0, title: 'Madrid Antrasit Dekor', image: "https://usakseramik.com/storage/552/conversions/2316-madrid-madrid-antrasit-dekor-face-gorseli-thumb.jpg", properties: ['S'], size: '30x80'),
      Face(id: 1, title: 'Madrid Antrasit Palm Dekor', image: "https://usakseramik.com/storage/553/conversions/2317-madrid-madrid-antrasir-palm-dekor-face-gorseli-thumb.jpg", properties: ['S'], size: '30x80'),
      Face(id: 2, title: 'Madrid Kahve', image: "https://usakseramik.com/storage/571/conversions/2312-madrid-madrid-kahve-face-gorseli-thumb.jpg", properties: ['S'], size: '30x80'),
      Face(id: 3, title: 'Madrid Bone', image: "https://usakseramik.com/storage/560/conversions/2313-madrid-madrid-bone-face-gorseli-thumb.jpg", properties: ['S'], size: '30x80'),
      Face(id: 4, title: 'Madrid Kahve Palm Dekor', image: "https://usakseramik.com/storage/572/conversions/2315-madrid-madrid-kahve-palm-dekor-face-gorseli-thumb.jpg", properties: ['S'], size: '30x80'),
      Face(id: 5, title: 'Madrid Kahve Dekor', image: "https://usakseramik.com/storage/573/conversions/2314-madrid-madrid-kahve-dekor-face-gorseli-thumb.jpg", properties: ['S'], size: '30x80'),
      Face(id: 6, title: 'Madrid Antrasit', image: "https://usakseramik.com/storage/554/conversions/2311-madrid-madrid-antrasit-face-gorseli-thumb.jpg", properties: ['S'], size: '30x80'),
      Face(id: 7, title: 'Madrid Bone', image: "https://usakseramik.com/storage/566/conversions/2318-madrid-madrid-bone-face-gorseli-thumb.jpg", properties: ['S'], size: '48x48'),
    ],
    color: [
      AppColors.filter4,
      AppColors.filter3,
    ],
  ),
];
