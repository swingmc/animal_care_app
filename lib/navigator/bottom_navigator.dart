import 'package:flutter/material.dart';
import 'package:animalCare/navigator/app_navigator.dart';
import 'package:animalCare/pages/map/map.dart';
import 'package:animalCare/pages/user_center/profile_page.dart';
import 'package:animalCare/pages/world/world_main_page.dart';
import 'package:animalCare/util/export_file.dart';

class BottomNavigator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BottomNavigatorState();

  static _BottomNavigatorState? of(BuildContext context) {
    return context.findAncestorStateOfType<_BottomNavigatorState>();
  }
}

class _BottomNavigatorState extends State<BottomNavigator>{
  final _activeColor = pressButtonColorRight;
  int _currentIndex = 0;
  static int initialPage = 0;
  final PageController _controller = PageController(initialPage: initialPage);
  late List<Widget> _pages;
  bool _hasBuild = false;

  void jumpToPage(int index) {
    setState(() {
      _currentIndex = index;
      _onJumpTp(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    _pages = [
      OldMapPage(),
      WorldMainPage(),
      ProfilePage()];
    if (!_hasBuild) {
      //页面第一次打开时通知打开的是哪个tab
      AppNavigator.getInstance()?.onBottomTabChange(
          initialPage, _pages[initialPage]);
      _hasBuild = true;
    }
    return Scaffold(
      body: PageView(
          controller: _controller,
          onPageChanged: (index) => _onJumpTp(index, pageChange: true),
          //pageView不滚动
          physics: NeverScrollableScrollPhysics(),
          children: [
            OldMapPage(),
            WorldMainPage(),
            ProfilePage(),
          ]
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => _onJumpTp(index),
        //底部icon选中时样式不变
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _activeColor,
        items: [
          _bottomItem(ICON_HOME, ICON_HOME_PRESS, 0),

          _bottomItem(ICON_WORLD, ICON_WORLD_PRESS, 2),

          _bottomItem(ICON_PROFILE, ICON_PROFILE_PRESS, 4),
        ],
      ),
    );
  }

  _bottomItem(String defaultIcon, String activeIcon, int index) {
    return BottomNavigationBarItem(
        icon: Image.asset(
          defaultIcon,
          width: 24,
          height: 24,
        ),
        activeIcon: Image.asset(
          activeIcon,
          width: 24,
          height: 24,
        ),
        label: "");
  }
  
  void _onJumpTp(int index, {pageChange = false}) {
    if (!pageChange) {
      //让PageView展示对应tab
      // _controller.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.linear);
      _controller.jumpToPage(index);
    } else {
      AppNavigator.getInstance()?.onBottomTabChange(index, _pages[index]);
    }
    setState(() {
      //控制选中第一个tab
      _currentIndex = index;
    });
  }
}