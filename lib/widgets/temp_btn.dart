import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';



class TempBtn extends StatelessWidget {
  final String svgSrc;
  final String title;
  final bool isActive;
  final Color activeColor;
  final VoidCallback onTap;

  const TempBtn({
    Key? key,
    required this.svgSrc,
    required this.title,
    required this.isActive,
    required this.activeColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            curve: Curves.easeInOutBack,
              duration: const Duration(milliseconds: 200),
              height: isActive ? 75 : 50,
              child: SvgPicture.asset(
                svgSrc,
                color: isActive ? activeColor : Colors.white38,
              )),
          SizedBox(
            height: 10,
          ),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              color: isActive ? activeColor : Colors.white38,
              fontSize: 16,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
            child: Text(
              title.toUpperCase(),
            ),
          ),
        ],
      ),
    );
  }
}
