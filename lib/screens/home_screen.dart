import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tesla_animated_app/constanins.dart';
import 'package:tesla_animated_app/controllers/home_controller.dart';
import 'package:tesla_animated_app/models/TyrePsi.dart';
import 'package:tesla_animated_app/widgets/battery_status.dart';
import 'package:tesla_animated_app/widgets/door_lock.dart';
import 'package:tesla_animated_app/widgets/temp_btn.dart';
import 'package:tesla_animated_app/widgets/tesla_bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _controller = HomeController();
  late final AnimationController _batterController;
  late final Animation<double> _batterIconAnimation;
  late final Animation<double> _batterStatusAnimation;
  late final AnimationController _tempAnimationController;
  late final Animation<double> _tempInfoAnimation;
  late final Animation<double> _carShiftAnimation;
  late final Animation<double> _tempGlowAnimation;
  late final AnimationController _tyreAnimationController;
  late final Animation<double> _tyre1Animation;
  late final Animation<double> _tyre2Animation;
  late final Animation<double> _tyre3Animation;
  late final Animation<double> _tyre4Animation;

  @override
  void initState() {
    super.initState();
    _batterController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _batterIconAnimation =
        CurvedAnimation(parent: _batterController, curve: Interval(0, 0.5));
    _batterStatusAnimation =
        CurvedAnimation(parent: _batterController, curve: Interval(0.6, 1));
    _tempAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _carShiftAnimation = CurvedAnimation(
        parent: _tempAnimationController, curve: Interval(0, 0.2));
    _tempInfoAnimation = CurvedAnimation(
        parent: _tempAnimationController, curve: Interval(0.4, 0.6));
    _tempGlowAnimation = CurvedAnimation(
        parent: _tempAnimationController, curve: Interval(0.6, 1));
    _tyreAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));

    _tyre1Animation = CurvedAnimation(
        parent: _tyreAnimationController, curve: Interval(0.34, 0.5));
    _tyre2Animation = CurvedAnimation(
        parent: _tyreAnimationController, curve: Interval(0.5, 0.65));
    _tyre3Animation = CurvedAnimation(
        parent: _tyreAnimationController, curve: Interval(0.65, 0.8));
    _tyre4Animation = CurvedAnimation(
        parent: _tyreAnimationController, curve: Interval(0.8, 1));

    _animations = [
      _tyre1Animation,
      _tyre2Animation,
      _tyre3Animation,
      _tyre4Animation,
    ];
  }

  @override
  void dispose() {
    _batterController.dispose();
    _controller.dispose();
    _tempAnimationController.dispose();
    _tyreAnimationController.dispose();
    super.dispose();
  }

  late final List<Animation<double>> _animations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => TeslaBottomNavigationBar(
          selectedIndex: _controller.selectedIndex,
          onTap: (index) {
            if (index == 1) {
              _batterController.forward();
            }
            if (_controller.selectedIndex == 1 && index != 1) {
              _batterController.reverse(from: 0.5);
            }
            if (index == 2) {
              _tempAnimationController.forward();
            }
            if (_controller.selectedIndex == 2 && index != 2) {
              _tempAnimationController.reverse(from: 0.2);
            }
            if (index == 3) {
              _controller.setShowTyres();
              _tyreAnimationController.forward();
            }
            if (_controller.selectedIndex == 3 && index != 3) {
              _controller.hideTyres();
              _tyreAnimationController.reverse();
              Future.delayed(const Duration(milliseconds: 200))
                  .then((value) => _controller.hideTyresStatus());
            }
            _controller.setIndex(index);
          },
        ),
      ),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: Listenable.merge(
              [_controller, _batterController, _tempAnimationController]),
          builder: (context, child) => LayoutBuilder(
            builder: (BuildContext context, constraints) {
              return Container(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                    ),
                    Positioned(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      left: _carShiftAnimation.value * constraints.maxWidth / 2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: constraints.maxHeight * .1),
                        child: SvgPicture.asset(
                          'assets/icons/Car.svg',
                          width: double.infinity,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      right: _controller.selectedIndex == 0
                          ? constraints.maxWidth * .05
                          : constraints.maxWidth / 2,
                      child: AnimatedOpacity(
                        opacity: _controller.selectedIndex == 0 ? 1 : 0,
                        duration: defaultDuration,
                        child: DoorLock(
                          isLocked: _controller.isRightDoorOpen,
                          onTap: _controller.toggleRightDoor,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      left: _controller.selectedIndex == 0
                          ? constraints.maxWidth * .05
                          : constraints.maxWidth / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedIndex == 0 ? 1 : 0,
                        child: DoorLock(
                          isLocked: _controller.isLeftDoorOpen,
                          onTap: _controller.toggleLeftDoor,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      top: _controller.selectedIndex == 0
                          ? constraints.maxHeight * .15
                          : constraints.maxHeight / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedIndex == 0 ? 1 : 0,
                        child: DoorLock(
                          isLocked: _controller.isTopDoorOpen,
                          onTap: _controller.toggleTopDoor,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      bottom: _controller.selectedIndex == 0
                          ? constraints.maxHeight * .17
                          : constraints.maxHeight / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedIndex == 0 ? 1 : 0,
                        child: DoorLock(
                          isLocked: _controller.isBottomDoorOpen,
                          onTap: _controller.toggleBottomDoor,
                        ),
                      ),
                    ),

                    // batter icon
                    Opacity(
                      opacity: _batterIconAnimation.value,
                      child: SvgPicture.asset('assets/icons/Battery.svg',
                          width: constraints.maxWidth * 0.45),
                    ),
                    // battery status
                    Positioned(
                        height: constraints.maxHeight,
                        width: constraints.maxWidth,
                        top: 50 * (1 - _batterStatusAnimation.value),
                        child: Opacity(
                            opacity: _batterStatusAnimation.value,
                            child: BatteryStatus(constraints: constraints))),
                    Positioned(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      top: 70 * (1 - _tempInfoAnimation.value),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Opacity(
                          opacity: _tempInfoAnimation.value,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 120,
                                child: Row(
                                  children: [
                                    TempBtn(
                                        svgSrc: 'assets/icons/coolShape.svg',
                                        title: 'Cool',
                                        activeColor: primaryColor,
                                        isActive: _controller.isCoolActive,
                                        onTap: () {
                                          _controller.setCool();
                                        }),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    TempBtn(
                                        svgSrc: 'assets/icons/heatShape.svg',
                                        title: 'Heat',
                                        activeColor: Colors.red,
                                        isActive: !_controller.isCoolActive,
                                        onTap: () {
                                          _controller.setHeat();
                                        }),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _controller.increaseTemp();
                                    },
                                    icon: Icon(
                                      Icons.arrow_drop_up,
                                      size: 35,
                                    ),
                                  ),
                                  Text(
                                    '${_controller.currentTemp} \u2103',
                                    style: TextStyle(
                                      fontSize: 60,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _controller.decreaseTemp();
                                    },
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      size: 35,
                                    ),
                                  )
                                ],
                              ),
                              Spacer(),
                              Text('CURRENT TEMPERATURE'),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text('INSIDE'),
                                      Text(
                                        '25 \u2103',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'OUTSIDE',
                                        style: TextStyle(
                                          color: Colors.white38,
                                        ),
                                      ),
                                      Text(
                                        '35 \u2103',
                                        style: TextStyle(
                                          color: Colors.white38,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      height: constraints.maxHeight,
                      width: 200,
                      right: (-180 * (1 - _tempGlowAnimation.value)) - 16,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: _controller.isCoolActive
                            ? Image.asset(
                                'assets/images/Cool_glow_2.png',
                                key: UniqueKey(),
                              )
                            : Image.asset(
                                'assets/images/Hot_glow_4.png',
                                key: UniqueKey(),
                              ),
                      ),
                    ),
                    if (_controller.showTyres) ...showTyres(constraints),
                    if (_controller.showTyresStatus)
                      SizedBox(
                        height: constraints.maxHeight,
                        width: constraints.maxWidth,
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(16),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio:
                                constraints.maxWidth / constraints.maxHeight,
                          ),
                          itemCount: 4,
                          itemBuilder: (context, index) => ScaleTransition(
                            scale: _animations[index],
                            child: Container(
                              decoration: BoxDecoration(
                                color: demoPsiList[index].isLowPressure
                                    ? Colors.red.withOpacity(0.1)
                                    : primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: demoPsiList[index].isLowPressure
                                      ? Colors.red
                                      : primaryColor,
                                  width: 1.4,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: index < 2
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            demoPsiList[index].psi.toString() +
                                                'psi',
                                            style: TextStyle(
                                              fontSize: 26,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            demoPsiList[index].temp.toString() +
                                                '\u2103',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          Spacer(),
                                          if (demoPsiList[index].isLowPressure)
                                            Text(
                                              'Low \nPressure'.toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 26,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (demoPsiList[index].isLowPressure)
                                            Text(
                                              'Low \nPressure'.toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 26,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          Spacer(),
                                          Text(
                                            demoPsiList[index].psi.toString() +
                                                'psi',
                                            style: TextStyle(
                                              fontSize: 26,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            demoPsiList[index].temp.toString() +
                                                '\u2103',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  List<Widget> showTyres(constraints) => [
        Positioned(
            top: constraints.maxHeight * 0.23,
            left: constraints.maxWidth * 0.22,
            child: SvgPicture.asset('assets/icons/FL_Tyre.svg')),
        Positioned(
            top: constraints.maxHeight * 0.23,
            right: constraints.maxWidth * 0.22,
            child: SvgPicture.asset('assets/icons/FL_Tyre.svg')),
        Positioned(
            bottom: constraints.maxHeight * 0.27,
            left: constraints.maxWidth * 0.22,
            child: SvgPicture.asset('assets/icons/FL_Tyre.svg')),
        Positioned(
            bottom: constraints.maxHeight * 0.27,
            right: constraints.maxWidth * 0.22,
            child: SvgPicture.asset('assets/icons/FL_Tyre.svg')),
      ];
}
