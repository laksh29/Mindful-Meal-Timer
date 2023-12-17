import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.index,
    required this.activeIndex,
  });

  final int index;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    final bool isActive = index == activeIndex;
    return CircleAvatar(
      backgroundColor: isActive ? Colors.white : Colors.white54,
      radius: isActive ? 10 : 8,
    );
  }
}
