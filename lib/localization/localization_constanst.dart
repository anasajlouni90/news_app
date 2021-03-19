import 'package:flutter/material.dart';
import 'package:news_app/localization/localization.dart';

String getTranslated(BuildContext context, String key) {
  return Localization.of(context).getTranslatedValue(key);
}
