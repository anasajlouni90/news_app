import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:news_app/localization/Language.dart';
import 'package:news_app/localization/localization_constanst.dart';
import 'package:news_app/main.dart';
import 'package:news_app/main_screen.dart';
import 'package:news_app/views/sources/source_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class First extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  SharedPreferences preferences;
  void _changeLanguage(Language language) {
    Locale _temp;
    switch (language.languageCode) {
      case 'en':
        _temp = Locale(language.languageCode, 'US');

        break;
      case 'ar':
        _temp = Locale(language.languageCode, 'SA');

        break;
      default:
        _temp = Locale(language.languageCode, 'US');
    }
    MyApp.setLocale(context, _temp);
  }

  getPrefrence() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    getPrefrence();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "images/img/news.jpg",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Container(
              color: Colors.black.withOpacity(0.9),
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 150.0),
                child: Image.asset(
                  "images/img/theworldnews.png",
                  width: 250,
                  height: 250,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 330.0),
                  child: Card(
                    color: Colors.white54,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 8.0,
                    child: Container(
                      height: 65,
                      width: 250,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, left: 15, bottom: 15),
                        child: DropdownButton(
                          onChanged: (Language language) {
                            _changeLanguage(language);
                          },
                          underline: SizedBox(),
                          hint: Text(getTranslated(context, "Choose language"),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 25)),
                          icon: Icon(
                            Icons.language,
                            color: Colors.black,
                          ),
                          items: Language.languageList()
                              .map<DropdownMenuItem<Language>>(
                                (lang) => DropdownMenuItem(
                                  value: lang,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(lang.flag),
                                      ),
                                      Text(lang.name),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: RaisedButton(
                    color: Colors.grey[400],
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(25),
                    child: Text(
                      getTranslated(context, "Next"),
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SourceScreen())),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
