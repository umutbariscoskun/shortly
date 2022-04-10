import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shortly/src/app/pages/home/home_view.dart';

class OnboardingController extends Controller {
  int forwardButtonCounter = 0;
  int pageIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  @override
  void initListeners() {
    // TODO: implement initListeners
  }

  void refreshScreen() {
    refreshUI();
  }

  void increaseForwardButtonCounter() {
    forwardButtonCounter += 1;
  }

  void onSkipButtonPressed() {
    pageController.animateToPage(pageIndex + 1,
        duration: Duration(milliseconds: 235), curve: Curves.linear);

    if (pageIndex == 2)
      Navigator.push(
          getContext(),
          MaterialPageRoute(
            builder: (context) => HomeView(),
          ));
  }
}
