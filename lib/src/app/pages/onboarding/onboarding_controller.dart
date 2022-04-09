import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class OnboardingController extends Controller {
  int forwardButtonCounter = 0;
  int pageIndex = 0;

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
}
