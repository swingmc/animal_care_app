import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animalCare/navigator/bottom_navigator.dart';
import 'package:animalCare/pages/login_page.dart';


typedef RouteChangeListener = Function(RouteStatusInfo current, RouteStatusInfo pre);

pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}


int getPageIndex(List<MaterialPage> pages, RouteStatus routeStatus) {
  for (int i = 0; i < pages.length; i++) {
    MaterialPage page = pages[i];
    if (getStatus(page) == routeStatus) {
      return i;
    }
  }
  return -1;
}

enum RouteStatus { login, register, forgetPwd, detail, home, unknown }


RouteStatus getStatus(MaterialPage page) {
  if (page.child is LoginPage) {
    return RouteStatus.login;
  }

  /*
  else if (page.child is SignUpPage) {
    return RouteStatus.register;
  }

  */
  else if (page.child is BottomNavigator) {
    return RouteStatus.home;
  }
  /*
  else if (page.child is VideoDetailPage) {
    return RouteStatus.detail;
  }
  */
  else {
    return RouteStatus.unknown;
  }

}

///路由信息
class RouteStatusInfo {
  final RouteStatus routeStatus;
  final Widget page;

  RouteStatusInfo(this.routeStatus, this.page);
}


class AppNavigator extends _RouteJumpListener {
  static AppNavigator? _instance;
  AppNavigator._();

  RouteJumpListener? _routeJump;
  List<RouteChangeListener> _listeners = [];
  RouteStatusInfo? _current;
  //首页底部tab
  RouteStatusInfo? _bottomTab;
  static AppNavigator? getInstance() {
    _instance ??= AppNavigator._();
    return _instance!;
  }

  ///首页底部tab切换监听
  void onBottomTabChange(int index, Widget page) {
    _bottomTab = RouteStatusInfo(RouteStatus.home, page);
    _notify(_bottomTab!);
  }

  ///注册路由跳转逻辑
  void registerRouteJump(RouteJumpListener routeJumpListener) {
   this. _routeJump = routeJumpListener;
  }

  ///监听路由页面跳转
  void addListener(RouteChangeListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  ///移除监听
  void removeListener(RouteChangeListener listener) {
    _listeners.remove(listener);
  }

  @override
  void onJumpTo(RouteStatus routeStatus, {Map? args}) {
    _routeJump?.onJumpTo(routeStatus, args: args);
  }

  ///通知路由页面变化
  void notify(List<MaterialPage> currentPages, List<MaterialPage> prePages) {
    if (currentPages == prePages) {
      return;
    }
    var current = RouteStatusInfo(
        getStatus(currentPages.last), currentPages.last.child);
    _notify(current);
  }

  void _notify(RouteStatusInfo current) {
    if (current.page is BottomNavigator && _bottomTab != null) {
      //如果打开的是首页，则明确到首页具体的tab
      current = _bottomTab!;
    }

    _listeners.forEach((listener) {
      listener(current, _current!);
    });
    _current = current;
  }
}

abstract class _RouteJumpListener {

  void onJumpTo(RouteStatus routeStatus, {Map? args});
}

typedef OnJumpTo = void Function(RouteStatus routeStatus, {Map? args});

class RouteJumpListener {
  final OnJumpTo onJumpTo;

  RouteJumpListener({required this.onJumpTo});
}