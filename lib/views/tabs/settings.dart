import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/open_scources.dart';
import 'package:news_app/helper/terms.dart';
import 'package:news_app/localization/Language.dart';
import 'package:news_app/localization/localization_constanst.dart';
import 'package:news_app/main.dart';
import 'package:news_app/views/sources/source_list.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool lockInBackground = true;
  bool notificationsEnabled = true;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: buildSettingsList(),
    );
  }

  Widget buildSettingsList() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: SettingsList(
        backgroundColor: Colors.white,
        sections: [
          SettingsSection(
            title: getTranslated(context, 'Settings'),
            titleTextStyle:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            tiles: [
              SettingsTile(
                title: getTranslated(context, 'choose_source'),
                leading: Icon(EvaIcons.grid),
                onPressed: (context) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SourceScreen(
                        language: getTranslated(context, "en"),
                      ),
                    ),
                  );
                },
              ),
              SettingsTile(
                title: '',
                subtitle: '',
                leading: DropdownButton(
                  onChanged: (Language language) {
                    _changeLanguage(language);
                  },
                  underline: SizedBox(),
                  hint: Text(
                    getTranslated(context, 'change_language'),
                  ),
                  icon: Icon(
                    Icons.language,
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
            ],
          ),
          SettingsSection(
            tiles: [
              SettingsTile(
                  title: getTranslated(context, 'Terms of Service'),
                  leading: Icon(Icons.description),
                  onPressed: (context) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Terms()),
                    );
                  }),
              SettingsTile(
                  title: getTranslated(context, 'Open source licenses'),
                  leading: Icon(Icons.collections_bookmark),
                  onPressed: (context) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OpenSource()),
                    );
                  }),
            ],
          ),
          CustomSection(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 190, bottom: 4),
                  child: Image.asset(
                    'images/img/applogo.png',
                    height: 50,
                    width: 50,
                    color: Color(0xFF777777),
                  ),
                ),
                Text(
                  ' Anas Ajlouni ®',
                  style: TextStyle(color: Color(0xFF777777)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: Text(
                    'Version: 1.0.0 ',
                    style: TextStyle(color: Color(0xFF777777)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
