import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shortly/src/app/constants.dart';
import 'package:shortly/src/app/pages/onboarding/onboarding_controller.dart';

class OnboardingView extends View {
  @override
  State<StatefulWidget> createState() {
    return _OnboardingViewState(OnboardingController());
  }
}

class _OnboardingViewState
    extends ViewState<OnboardingView, OnboardingController> {
  _OnboardingViewState(OnboardingController controller) : super(controller);

  @override
  Widget get view {
    PageController pageController = PageController(initialPage: 0);

    Size size = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: globalKey,
        backgroundColor: kBackGroundColor,
        body: Column(
          children: [
            ControlledWidgetBuilder<OnboardingController>(
              builder: (context, controller) {
                return Expanded(
                  child: PageView(
                    controller: pageController,
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      controller.pageIndex = index;
                      controller.refreshScreen();
                    },
                    children: [
                      _OnboardCard(
                        title: "SAYFA 1",
                        content: "SAYFA 1 İÇERİĞİ",
                        buttonOnpressed: () {
                          pageController.animateToPage(1,
                              duration: Duration(milliseconds: 235),
                              curve: Curves.linear);
                        },
                        index: 0,
                        increaseForwardButtonCounter:
                            controller.increaseForwardButtonCounter,
                        forwardButtonCounter: controller.forwardButtonCounter,
                      ),
                      _OnboardCard(
                        title: "SAYFA 2",
                        content: "SAYFA 2 İÇERİĞİ",
                        buttonOnpressed: () {
                          pageController.animateToPage(2,
                              duration: Duration(milliseconds: 235),
                              curve: Curves.linear);
                        },
                        index: 1,
                        increaseForwardButtonCounter:
                            controller.increaseForwardButtonCounter,
                        forwardButtonCounter: controller.forwardButtonCounter,
                      ),
                      _OnboardCard(
                        title: "SAYFA 3",
                        content: "SAYFA 3 İÇERİĞİ",
                        buttonOnpressed: () {
                          pageController.animateToPage(3,
                              duration: Duration(milliseconds: 235),
                              curve: Curves.linear);
                        },
                        index: 2,
                        increaseForwardButtonCounter:
                            controller.increaseForwardButtonCounter,
                        forwardButtonCounter: controller.forwardButtonCounter,
                      ),
                      _OnboardCard(
                        title: "SAYFA 4",
                        content: "SAYFA 4 İÇERİĞİ",
                        buttonOnpressed: () {},
                        index: 3,
                        increaseForwardButtonCounter:
                            controller.increaseForwardButtonCounter,
                        forwardButtonCounter: controller.forwardButtonCounter,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardCard extends StatelessWidget {
  final String title;
  final String content;
  final Function() buttonOnpressed;
  final int index;
  final Function() increaseForwardButtonCounter;
  final int forwardButtonCounter;

  const _OnboardCard({
    required this.title,
    required this.content,
    required this.buttonOnpressed,
    required this.index,
    required this.increaseForwardButtonCounter,
    required this.forwardButtonCounter,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    double topPadding = MediaQuery.of(context).padding.top;

    return SizedBox(
      width: size.width,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        child: Stack(
          children: [
            SizedBox(
              width: size.width,
              height: size.height,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Image(
                          image: AssetImage("assets/icons/shortly.png"),
                        ),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
                            color: kBlack,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 28,
                          ),
                          child: Text(
                            content,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kBlack,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              height: 1.7,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20, top: 15),
                    width: 32,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            color: index == 0
                                ? kPrimaryColor
                                : Color(0xFFC4C4C4).withOpacity(0.29),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            color: index == 1
                                ? kPrimaryColor
                                : Color(0xFFC4C4C4).withOpacity(0.29),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            color: index == 2
                                ? kPrimaryColor
                                : Color(0xFFC4C4C4).withOpacity(0.29),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            color: index == 3
                                ? kPrimaryColor
                                : Color(0xFFC4C4C4).withOpacity(0.29),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text("Skip"),
                  SizedBox(
                    height: bottomPadding + 50,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
