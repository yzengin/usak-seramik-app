class OnboardItem {
  int id;
  String? title;
  String? description;
  String? image;
  OnboardItem({
    required this.id,
    this.title,
    this.description,
    this.image,
  });
}

List<OnboardItem> onboardList = [
  OnboardItem(
    id: 0,
    title: 'Uşak Seramik',
    description: 'Trend Ürünleri Uygulamamızdan takip edin',
    image: 'https://usakseramik.com/storage/931/15703-carrara-mekan-gorseli.jpg',
  ),
  OnboardItem(
    id: 1,
    title: 'Seramik Sanatında Yenilikçi Perspektif',
    description: 'Geleneksel seramiklerin 40 yıllık tecrübemiz ile çağdaş yorumlarını deneyimleyin',
    image: 'https://usakseramik.com/storage/283/15635-madrid-mekan-gorseli.jpg',
  ),
];
