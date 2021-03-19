import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:news_app/localization/Language.dart';
import 'package:news_app/localization/localization_constanst.dart';
import 'package:news_app/main.dart';
import 'package:news_app/main_screen.dart';
import 'package:news_app/views/sources/source_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseLanguage extends StatefulWidget {
  @override
  _ChooseLanguageState createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  SharedPreferences preferences;
  Language language;
  void changeLanguage(Language language) {
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



  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "images/img/home.jpg",
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Container(
              color: Colors.black.withOpacity(0.5),
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 200.0),
                child: Image.asset(
                  "images/img/news.png",
                  width: 150,
                  height: 150,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 320.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              offset: Offset(1, 1),
                              blurRadius: 10)
                        ]),
                    child: DropdownButton(
                      onChanged: (Language language) {
                        changeLanguage(language);
                      },
                      underline: SizedBox(),
                      hint: Text(getTranslated(context, "Choose language"),
                          style: TextStyle(color: Colors.white, fontSize: 25)),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
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
              RaisedButton(
                child: Text(getTranslated(context, "Next")),
                onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SourceScreen(
                              language: getTranslated(context, "en"),
                            ))),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
