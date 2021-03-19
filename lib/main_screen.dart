import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:news_app/bloc/bottom_navigation_bar_bloc.dart';
import 'package:news_app/localization/localization_constanst.dart';
import 'package:news_app/views/categories/category_list.dart';
import 'package:news_app/views/sources/my_sources.dart';
import 'package:news_app/views/tabs/home_tabBar.dart';
import 'package:news_app/views/tabs/search.dart';
import 'package:news_app/views/tabs/settings.dart';

class MainScreen extends StatefulWidget {
  String sourccid;
  MainScreen({this.sourccid});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String sourccid;
  BottomNavBarBloc _bottomNavBarBloc;

  List dataList = [];

  @override
  void initState() {
    super.initState();
    _bottomNavBarBloc = BottomNavBarBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
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
        child: StreamBuilder<navBarItem>(
          stream: _bottomNavBarBloc.itemSteam,
          initialData: _bottomNavBarBloc.defaultItem,
          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot<navBarItem> snapshot) {
            switch (snapshot.data) {
              case navBarItem.HOME:
                return HomeTabBar();
              case navBarItem.CATEGORY:
                return CategoryList();
              case navBarItem.MYSOURCES:
                return MySources(
                  sourceName: widget.sourccid,
                );
              case navBarItem.SETTING:
                return SettingsScreen();
              case navBarItem.SEARCH:
                return SearchScreen();
            }
          },
        ),
      ),
      bottomNavigationBar: StreamBuilder<navBarItem>(
        stream: _bottomNavBarBloc.itemSteam,
        initialData: _bottomNavBarBloc.defaultItem,
        // ignore: missing_return
        builder: (BuildContext context, AsyncSnapshot<navBarItem> snapshot) {
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
                onTap: _bottomNavBarBloc.pickItem,
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
