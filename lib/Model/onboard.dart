import '../Controller/asset.dart';

class OnboardItem {
  int id;
  String? title;
  String? description;
  String? image;
  String? imageAsset;
  OnboardItem({
    required this.id,
    this.title,
    this.description,
    this.image,
    this.imageAsset,
  });
}

List<OnboardItem> onboardList = [
  OnboardItem(
    id: 0,
    title: 'Uşak Seramik',
    description: 'Trend Ürünleri Uygulamamızdan takip edin',
    imageAsset: AppImage.onboardImage1,
    image: 'https://usakseramik.com/storage/931/15703-carrara-mekan-gorseli.jpg',
  ),
  OnboardItem(
    id: 1,
    title: 'Seramik Sanatında Yenilikçi Perspektif',
    description: 'Geleneksel seramiklerin 40 yıllık tecrübemiz ile çağdaş yorumlarını deneyimleyin',
    imageAsset: AppImage.onboardImage2,
    image: 'https://usakseramik.com/storage/283/15635-madrid-mekan-gorseli.jpg',
  ),
];
