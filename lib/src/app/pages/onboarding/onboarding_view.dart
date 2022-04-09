import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shortly/src/app/constants.dart';
import 'package:shortly/src/app/pages/onboarding/onboarding_controller.dart';
import 'package:shortly/src/app/texts.dart';

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
    Size size = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: globalKey,
        backgroundColor: kBackGroundColor,
        body: Column(
          children: [
            Container(
              width: 150,
              height: 150,
              child: Image(
                image: AssetImage("assets/icons/shortly.png"),
              ),
            ),
            ControlledWidgetBuilder<OnboardingController>(
              builder: (context, controller) {
                return Expanded(
                  child: PageView(
                    controller: controller.pageController,
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
                          controller.pageController.animateToPage(1,
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
                          controller.pageController.animateToPage(2,
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
                          controller.pageController.animateToPage(3,
                              duration: Duration(milliseconds: 235),
                              curve: Curves.linear);
                        },
                        index: 2,
                        increaseForwardButtonCounter:
                            controller.increaseForwardButtonCounter,
                        forwardButtonCounter: controller.forwardButtonCounter,
                      ),
                    ],
                  ),
                );
              },
            ),
            ControlledWidgetBuilder<OnboardingController>(
              builder: (context, controller) {
                return Container(
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
                          color: controller.pageIndex == 0
                              ? kPrimaryColor
                              : Color(0xFFC4C4C4).withOpacity(0.29),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: controller.pageIndex == 1
                              ? kPrimaryColor
                              : Color(0xFFC4C4C4).withOpacity(0.29),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: controller.pageIndex == 2
                              ? kPrimaryColor
                              : Color(0xFFC4C4C4).withOpacity(0.29),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            ControlledWidgetBuilder<OnboardingController>(
              builder: (context, controller) {
                return _SkipButton(
                  controller.onSkipButtonPressed,
                  controller.forwardButtonCounter,
                  controller.increaseForwardButtonCounter,
                );
              },
            ),
            SizedBox(
              height: padding.bottom + 50,
            )
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
    return Container(
      width: size.width,
      height: size.height * 0.46,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkipButton extends StatelessWidget {
  final Function()? onPressed;
  final int? forwardButtonCounterValue;
  final Function()? increaseCounter;

  _SkipButton(
    this.onPressed,
    this.forwardButtonCounterValue,
    this.increaseCounter,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          increaseCounter!();

          onPressed!();
        },
        child: Container(
          child: Text(
            ShortlyTexts.skip,
          ),
        ));
  }
}

class _DefaultButton extends StatelessWidget {
  final Function()? onPressed;
  final Function()? increaseCounter;
  final int? getForwardButtonCounterValue;
  final String text;
  final bool isAvailable;

  _DefaultButton({
    required this.onPressed,
    this.increaseCounter,
    this.getForwardButtonCounterValue,
    required this.text,
    required this.isAvailable,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          3,
        ),
      ),
      width: 109,
      height: 50,
      child: TextButton(
        child: Text(
          text,
          style: TextStyle(
            color: kWhite,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        onPressed: () {
          if (increaseCounter != null) increaseCounter!();
          if (isAvailable != false &&
              (getForwardButtonCounterValue == null ||
                  getForwardButtonCounterValue != null)) onPressed!();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
            (_) => isAvailable ? kPrimaryColor : kDisabledButtonColor,
          ),
          padding: MaterialStateProperty.resolveWith(
            (_) => EdgeInsets.zero,
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          overlayColor: MaterialStateProperty.resolveWith(
            (_) => Colors.transparent,
          ),
          minimumSize: MaterialStateProperty.resolveWith(
            (_) => Size(
              0,
              0,
            ),
          ),
        ),
      ),
    );
  }
}
