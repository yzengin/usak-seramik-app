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
    title: 'Huzurlu Doğa',
    description: 'Sakin ve huzurlu doğayı keşfedin. Şehir gürültüsünden uzaklaşın ve doğanın tadını çıkarın.',
    image: 'https://wallpaperaccess.com/full/82311.jpg',
  ),
  OnboardItem(
    id: 1,
    title: 'Yenilikçi Teknoloji',
    description: 'Gelişmiş ve yenilikçi teknolojilerle donatılmış ürünlerimiz ile hayatınızı kolaylaştırın.',
    image: 'https://img.freepik.com/premium-photo/therapist-client-calming-therapy-session-discussing-mental-health-strategies_818261-9162.jpg?w=1480_etetet',
  ),
  OnboardItem(
    id: 2,
    title: 'Eğlenceli Etkinlikler',
    description: 'Eğlence dolu etkinliklerle zamanınızı keyifli ve unutulmaz anlara dönüştürün.',
    image: 'https://img.freepik.com/premium-vector/social-media-people-young-women-man-using-social-networks-mobile-internet-messaging-comments-posting-put-likes-vector-concept_533410-24.jpg?w=2000',
  ),
];
