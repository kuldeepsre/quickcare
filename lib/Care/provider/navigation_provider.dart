import 'package:flutter/foundation.dart';

class NavigationProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changePage(int index) {
    if (index < 0 || index > 4 || index == _currentIndex) {
      return;
    }

    _currentIndex = index;
    notifyListeners();
  }
}