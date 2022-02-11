import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tesla_animated_app/constanins.dart';

class TeslaBottomNavigationBar extends StatelessWidget {
  const TeslaBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  final int selectedIndex;
  final ValueChanged<int> onTap;

  final _items = const [
    'assets/icons/Lock.svg',
    'assets/icons/Charge.svg',
    'assets/icons/Temp.svg',
    'assets/icons/Tyre.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.black,
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.black,
        fixedColor: Colors.black,
        currentIndex: selectedIndex,
        onTap: onTap,
        items: List.generate(
          _items.length,
          (index) => BottomNavigationBarItem(
            label: '',
            icon: SvgPicture.asset(
              _items[index],
              color: index == selectedIndex ? primaryColor : Colors.white54,
            ),
          ),
        ),
      ),
    );
  }
}
