import 'dart:async';

enum navBarItem { HOME, CATEGORY, MYSOURCES, SEARCH, SETTING }

class BottomNavBarBloc {
  final StreamController<navBarItem> _navBarController =
      StreamController<navBarItem>.broadcast();

  navBarItem defaultItem = navBarItem.MYSOURCES;

  Stream<navBarItem> get itemSteam => _navBarController.stream;

  void pickItem(int i) {
    switch (i) {
      case 0:
        _navBarController.sink.add(navBarItem.HOME);
        break;
      case 1:
        _navBarController.sink.add(navBarItem.CATEGORY);
        break;
      case 2:
        _navBarController.sink.add(navBarItem.MYSOURCES);
        break;
      case 3:
        _navBarController.sink.add(navBarItem.SEARCH);
        break;
      case 4:
        _navBarController.sink.add(navBarItem.SETTING);
    }
  }

  close() {
    _navBarController?.close();
  }
}
