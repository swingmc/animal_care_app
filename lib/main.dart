import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:animalCare/db/local_cache.dart';
import 'package:animalCare/http/dao/login_dao.dart';
import 'package:animalCare/navigator/bottom_navigator.dart';
import 'package:animalCare/pages/login_page.dart';
import 'package:animalCare/util/provider/collection_provider.dart';
import 'navigator/app_navigator.dart';
import 'package:animalCare/logger/logger.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:animalCare/generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animalCare/util/export_file.dart';
import 'package:provider/provider.dart';

final myDataProvider = MyDataProvider();
final shareMediaProvider = ShareMediaProvider();


String FCM_TOKEN = "";

ThemeData get appThemeData => ThemeData(
  canvasColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
);

void main() async {
  //copy adll init code in runApp()，refer to https://docs.flutter.dev/release/breaking-changes/zone-errors
  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized(); //不加这个强制横/竖屏会报错
    SystemChrome.setPreferredOrientations([
      // 强制竖屏
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light
    ));

    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp().then((value){
      //FirebaseAppCheck.instance.activate();
    });

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => myDataProvider),
      ChangeNotifierProvider(
          create: (_) => shareMediaProvider),
    ], child: AnimalCare())

  );
  }, (error, stackTrace) {
    logger.fatal('Caught error: $error, StackTrace: $stackTrace', stackTrace, moudle:Moudle.OTHER, problemType: ProblemType.OTHER);
  });
}

class AnimalCare extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnimalCareApp();
}

class _AnimalCareApp extends State<AnimalCare> {
  AnimalCareRouteDelegate _routeDelegate = AnimalCareRouteDelegate();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LocalCache>(
      future: LocalCache.preInit(),
        builder: (BuildContext context, AsyncSnapshot<LocalCache> snapshot) {
          //var test = S.of(context).all_equipment;
          var widget = snapshot.connectionState == ConnectionState.done
           ? Router(routerDelegate: _routeDelegate)
              : Scaffold(
              body: Center(
                  child: CircularProgressIndicator()
              )
          );
          return MaterialApp(
            theme: ThemeData.light().copyWith(
              scaffoldBackgroundColor: Colors.white, // 设置整个页面背景颜色
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.black,
                elevation: 0,
              ),
            ),
            builder: (context, widget) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
                child: widget!,
              );
            },
            home: ShowCaseWidget(builder: (context) => widget),
            locale: getDesiredLocale(),
            localizationsDelegates: [
              S.delegate,
              //AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            //TODO choose preferred language
            supportedLocales: [
              getDesiredLocale(),
            ],
          );
        });
  }

}

class AnimalCareRouteDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier,PopNavigatorRouterDelegateMixin<AppRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  bool get hasLogin => LoginDao.getLoginState() != null;

  AnimalCareRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {

    AppNavigator.getInstance()?.registerRouteJump(RouteJumpListener(
        onJumpTo: (RouteStatus routeStatus, {Map? args}) {
      _routeStatus = routeStatus;
      notifyListeners();
    }));

  }
  RouteStatus _routeStatus = RouteStatus.home;
  List<MaterialPage> pages = [];
  //VideoModel? videoModel;

  @override
  Widget build(BuildContext context) {
    //管理路由堆栈
    var index = getPageIndex(pages, routeStatus);
    var page;
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      tempPages = tempPages.sublist(0, index);
    }
    if (routeStatus == RouteStatus.home) {
      //跳转首页时将其他页面出栈
      pages.clear();
      page = pageWrap(BottomNavigator());
    }

    else if (routeStatus == RouteStatus.login) {
      //page = pageWrap(OldMapPage());
      page = pageWrap(LoginPage());
    }

    tempPages = [...tempPages, page];

    AppNavigator.getInstance()?.notify(tempPages, pages);
    pages = tempPages;

    return Localizations(
      locale: getDesiredLocale(),
      delegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        ],
      child: Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        var tempPages = [...pages];
        pages.removeLast();
        //通知路由发生变化
        AppNavigator.getInstance()?.notify(pages, tempPages);
        return true;
      },
    ),
    );
  }

  RouteStatus get routeStatus {
    if (_routeStatus != RouteStatus.register
        && _routeStatus != RouteStatus.forgetPwd && !hasLogin) {
      return _routeStatus = RouteStatus.login;
    } else {
      return _routeStatus;
    }
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath path) async {

  }
}
class AppRoutePath {
  final String location;
  AppRoutePath.home() : location = "/";
  AppRoutePath.detail() : location = "/detail";
}



Iterable<Locale> supportedLocales = [
  Locale('en', ''), // English, no country code
  // Locale('zh', 'CN'), // Chinese, China];
];

Locale getDesiredLocale() {
  // Get the current locale from the window
  // final locale = ui.window.locale;
  // if(locale.languageCode == "zh"){
  //   return Locale('zh', '');
  // }else{
  //   return Locale('en', '');
  // }
  return Locale('en', '');

}