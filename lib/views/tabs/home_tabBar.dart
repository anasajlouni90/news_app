import 'package:flutter/material.dart';
import 'package:news_app/localization/localization_constanst.dart';
import 'package:news_app/views/tabs/home_top_news.dart' as TopNews;
import 'package:news_app/views/categories/category_list_tapBar/category_business.dart'
    as Business;
import 'package:news_app/views/categories/category_list_tapBar/category_health.dart'
    as Health;
import 'package:news_app/views/categories/category_list_tapBar/category_sports.dart'
    as Sports;
import 'package:news_app/views/categories/category_list_tapBar/category_entertainment.dart'
    as Entertainment;
import 'package:news_app/views/categories/category_list_tapBar/category_technology.dart'
    as Technology;
import 'package:news_app/views/categories/category_list_tapBar/category_science.dart'
    as Science;
import 'package:news_app/views/tabs/Most_reading_news.dart' as General;

class HomeTabBar extends StatefulWidget {
  @override
  _HomeTabBarState createState() => _HomeTabBarState();
}

class _HomeTabBarState extends State<HomeTabBar>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 8, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          elevation: 0.0,
          bottom: TabBar(
            isScrollable: true,
            controller: tabController,
            indicatorColor: Colors.lightBlueAccent[400],
            enableFeedback: true,
            tabs: [
              Tab(
                text: getTranslated(context, 'Latest'),
              ),
              Tab(
                text: getTranslated(context, 'General'),
              ),
              Tab(
                text: getTranslated(context, 'Business'),
              ),
              Tab(
                text: getTranslated(context, 'Health'),
              ),
              Tab(
                text: getTranslated(context, 'Sports'),
              ),
              Tab(
                text: getTranslated(context, 'Entertainment'),
              ),
              Tab(
                text: getTranslated(context, 'Technology'),
              ),
              Tab(
                text: getTranslated(context, 'Science'),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          TopNews.Home(
            language: getTranslated(context, 'en'),
          ),
          General.HotNews(
            language: getTranslated(context, 'en'),
          ),
          Business.CategoryNewsBusiness(
            language: getTranslated(context, 'en'),
          ),
          Health.CategoryNewsHealth(
            language: getTranslated(context, 'en'),
          ),
          Sports.CategoryNewsSports(
            language: getTranslated(context, 'en'),
          ),
          Entertainment.CategoryNewsEntertainment(
            language: getTranslated(context, 'en'),
          ),
          Technology.CategoryNewsTechnology(
            language: getTranslated(context, 'en'),
          ),
          Science.CategoryNewsScience(
            language: getTranslated(context, 'en'),
          ),
        ],
      ),
    );
  }
}
