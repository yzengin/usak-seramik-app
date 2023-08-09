import '/controller/notifiers.dart';
import '/model/data.dart';

class PageViewIndexer {
  static final PageViewIndexer _instance = PageViewIndexer._internal();
  factory PageViewIndexer() => _instance;
  PageViewIndexer._internal();
  static get instance => _instance;
  int previousIndex = 0;
  int currentIndex = 0;
  Future<void> next(int index) async {
    previousIndex = currentIndex;
    currentIndex = index;
    onRouteNotifier.value = DualData("index of $currentIndex", "index of $previousIndex");
  }

  Future<int> previous() async {
    int mid = currentIndex;
    currentIndex = previousIndex;
    previousIndex = mid;
    onRouteNotifier.value = DualData("index of $currentIndex", "index of $previousIndex");
    return currentIndex;
  }
}
