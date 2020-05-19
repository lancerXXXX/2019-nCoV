import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:nav_router/nav_router.dart';

import 'components/splash.dart';
import 'components/tab.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BotToastInit(
        child: MaterialApp(
      title: '疫情信息',
      navigatorKey: navGK,
      debugShowCheckedModeBanner: false,
      theme: ThemeData( primaryColor: Colors.blue),
      localizationsDelegates: [
        //国际化
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        const FallbackCupertinoLocalisationsDelegate(),
      ],
      navigatorObservers: [BotToastNavigatorObserver()],
      supportedLocales: [
        //国际化
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
      home: Splash(),
      routes: <String, WidgetBuilder>{
        '/Tab': (BuildContext context) => TabWidget()
      },
    ));
  }
}

class FallbackCupertinoLocalisationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      DefaultCupertinoLocalizations.load(locale);

  @override
  bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
}
