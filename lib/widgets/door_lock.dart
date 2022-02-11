import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tesla_animated_app/constanins.dart';

class DoorLock extends StatelessWidget {
  const DoorLock({Key? key, required this.onTap, required this.isLocked})
      : super(key: key);

  final bool isLocked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedSwitcher(
        duration: defaultDuration,
        switchInCurve: Curves.easeInOutBack,
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: child,
        ),
        child: isLocked
            ? SvgPicture.asset(
                'assets/icons/door_lock.svg',
                key: ValueKey('lock'),
              )
            : SvgPicture.asset(
                'assets/icons/door_unlock.svg',
                key: ValueKey('unlock'),
              ),
      ),
    );
  }
}
