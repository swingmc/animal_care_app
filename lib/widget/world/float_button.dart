import 'package:flutter/material.dart';
import 'package:animalCare/pages/world/world_share_page.dart';

import '../../util/color.dart';

class WorldFloatButton extends StatefulWidget {
  const WorldFloatButton({super.key});

  @override
  State<WorldFloatButton> createState() => _WorldFloatButtonState();
}

class _WorldFloatButtonState extends State<WorldFloatButton> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Animation has completed, navigate to the next page
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const WorldSharePage()),
        );
      }
    });

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPressed() {
    setState(() {
      _isPressed = !_isPressed;
      if (_isPressed) {
        _controller.forward().then((_) {
          _controller.reverse();
          _isPressed = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [worldFloatTopColor, worldFloatBottomColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          shape: BoxShape.circle),
        child: FloatingActionButton(
          onPressed: _onPressed,
          backgroundColor: Colors.transparent,
          shape: const CircleBorder(), // 图标可以更改为发布图标
          elevation: 0,
          child: const Icon(Icons.add, color: Colors.white, size: 44), // 去掉阴影效果
        ),
      ),
    );
  }
}
