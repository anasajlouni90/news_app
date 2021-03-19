import 'dart:async';

enum navBarItems { HOME, CATEGORY, MYSOURCES, SEARCH, SETTING }

class BottomNavBarsBloc {
  final StreamController<navBarItems> _navBarsController =
      StreamController<navBarItems>.broadcast();

  navBarItems defaultItem = navBarItems.HOME;

  Stream<navBarItems> get itemSteam => _navBarsController.stream;

  void pickItem(int i) {
    switch (i) {
      case 0:
        _navBarsController.sink.add(navBarItems.HOME);
        break;
      case 1:
        _navBarsController.sink.add(navBarItems.CATEGORY);
        break;
      case 2:
        _navBarsController.sink.add(navBarItems.MYSOURCES);
        break;
      case 3:
        _navBarsController.sink.add(navBarItems.SEARCH);
        break;
      case 4:
        _navBarsController.sink.add(navBarItems.SETTING);
    }
  }

  close() {
    _navBarsController?.close();
  }
}
