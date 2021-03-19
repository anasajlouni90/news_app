import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:news_app/localization/localization.dart';
import 'package:news_app/views/first_screen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  SharedPreferences prefrences;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    getPrefrences();
  }

  getPrefrences() async {
    prefrences = await SharedPreferences.getInstance();
   readPrefrences();
  }

  @override
  Widget build(BuildContext context) {
    OneSignal.shared.init('ac866bbf-5ad3-416a-a594-da16a4545bd8');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      locale: _locale,
      supportedLocales: [Locale("en", "US"), Locale("ar", "SA")],
      localizationsDelegates: [
        Localization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (var locale in supportedLocales) {
          
          if (locale.languageCode == deviceLocale.languageCode &&
              locale.countryCode == deviceLocale.countryCode) {
            print('this loacale : ${locale.languageCode}');

            return deviceLocale;
          }

        }

        return supportedLocales.first;
      },
      home: First(),
    );
  }

  savePrefrences() async {
    prefrences = await SharedPreferences.getInstance();

    return prefrences.setString("languageCode", _locale.languageCode);
  }

  Future<String> readPrefrences() async {
    prefrences = await SharedPreferences.getInstance();
    setState(() {});
    return prefrences.getString('languageCode');
  }
}
