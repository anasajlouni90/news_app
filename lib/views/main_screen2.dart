import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:news_app/bloc/bottom_navigation_bar_bloc2.dart';
import 'package:news_app/localization/localization_constanst.dart';
import 'package:news_app/views/categories/category_list.dart';
import 'package:news_app/views/sources/my_sources.dart';
import 'package:news_app/views/tabs/home_tabBar.dart';
import 'package:news_app/views/tabs/search.dart';
import 'package:news_app/views/tabs/settings.dart';

class MainScreen2 extends StatefulWidget {
  @override
  _MainScreen2State createState() => _MainScreen2State();
}

class _MainScreen2State extends State<MainScreen2> {
  String sourccid;
  BottomNavBarsBloc _bottomNavBarsBloc;

  @override
  void initState() {
    super.initState();
    _bottomNavBarsBloc = BottomNavBarsBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "THE WORLD NEWS",
                  style: TextStyle(
                      color: Colors.lightBlueAccent[400], fontSize: 27),
                ),
              ),
            ],
          ),
          elevation: 0.0,
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<navBarItems>(
          stream: _bottomNavBarsBloc.itemSteam,
          initialData: _bottomNavBarsBloc.defaultItem,
          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot<navBarItems> snapshot) {
            switch (snapshot.data) {
              case navBarItems.HOME:
                return HomeTabBar();
              case navBarItems.CATEGORY:
                return CategoryList();
              case navBarItems.MYSOURCES:
                return MySources();
              case navBarItems.SETTING:
                return SettingsScreen();
              case navBarItems.SEARCH:
                return SearchScreen();
            }
          },
        ),
      ),
      bottomNavigationBar: StreamBuilder<navBarItems>(
        stream: _bottomNavBarsBloc.itemSteam,
        initialData: _bottomNavBarsBloc.defaultItem,
        // ignore: missing_return
        builder: (BuildContext context, AsyncSnapshot<navBarItems> snapshot) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[100],
                    spreadRadius: 0,
                    blurRadius: 10,
                  ),
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                iconSize: 20,
                unselectedItemColor: Colors.grey,
                unselectedFontSize: 9.5,
                selectedFontSize: 9.5,
                type: BottomNavigationBarType.fixed,
                fixedColor: Colors.lightBlueAccent[400],
                currentIndex: snapshot.data.index,
                onTap: _bottomNavBarsBloc.pickItem,
                items: [
                  BottomNavigationBarItem(
                    title: Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(getTranslated(context, 'home')),
                    ),
                    icon: Icon(EvaIcons.homeOutline),
                    activeIcon: Icon(EvaIcons.home),
                  ),
                  BottomNavigationBarItem(
                    title: Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(getTranslated(context, 'category')),
                    ),
                    icon: Icon(Icons.category_outlined),
                    activeIcon: Icon(Icons.category),
                  ),
                  BottomNavigationBarItem(
                    title: Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(getTranslated(context, 'My Sources')),
                    ),
                    icon: Icon(EvaIcons.gridOutline),
                    activeIcon: Icon(EvaIcons.grid),
                  ),
                  BottomNavigationBarItem(
                    title: Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(getTranslated(context, 'search')),
                    ),
                    icon: Icon(EvaIcons.searchOutline),
                    activeIcon: Icon(EvaIcons.search),
                  ),
                  BottomNavigationBarItem(
                    title: Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(getTranslated(context, 'settings')),
                    ),
                    icon: Icon(EvaIcons.settingsOutline),
                    activeIcon: Icon(EvaIcons.settings),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
