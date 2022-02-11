import 'package:flutter/cupertino.dart';

class HomeController extends ChangeNotifier {
  bool isRightDoorOpen = false;

  void toggleRightDoor() {
    isRightDoorOpen = !isRightDoorOpen;
    notifyListeners();
  }

  bool isLeftDoorOpen = false;

  void toggleLeftDoor() {
    isLeftDoorOpen = !isLeftDoorOpen;
    notifyListeners();
  }

  bool isTopDoorOpen = false;

  void toggleTopDoor() {
    isTopDoorOpen = !isTopDoorOpen;
    notifyListeners();
  }

  bool isBottomDoorOpen = false;

  void toggleBottomDoor() {
    isBottomDoorOpen = !isBottomDoorOpen;
    notifyListeners();
  }

// nav bar

  int selectedIndex = 0;
  void setIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  // temp

  bool isCoolActive = true;

  void setCool() {
    isCoolActive = true;
    notifyListeners();
  }

  void setHeat() {
    isCoolActive = false;
    notifyListeners();
  }

  int currentTemp = 25;

  void increaseTemp() {
    currentTemp++;
    notifyListeners();
  }

  void decreaseTemp() {
    currentTemp--;
    notifyListeners();
  }

  // tyres

  bool showTyres = false;
  bool showTyresStatus = false;

  void setShowTyres() async {
    await Future.delayed(const Duration(milliseconds: 300));
    showTyres = true;
    showTyresStatus = true;
    notifyListeners();
  }

  void hideTyres() {
    showTyres = false;
    notifyListeners();
  }

  void hideTyresStatus() {
    showTyresStatus = false;
    notifyListeners();
  }
}
