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
                        title: ShortlyTexts.brandRecognation,
                        content: ShortlyTexts.boosYourBrand,
                      ),
                      _OnboardCard(
                        title: ShortlyTexts.detailedRecords,
                        content: ShortlyTexts.gainInsightsInto,
                      ),
                      _OnboardCard(
                        title: ShortlyTexts.fullyCustomizable,
                        content: ShortlyTexts.imroveBrand,
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
                        width: controller.pageIndex == 0 ? 7 : 5,
                        height: controller.pageIndex == 0 ? 7 : 5,
                        decoration: controller.pageIndex == 0
                            ? BoxDecoration(
                                color: kGrey,
                                shape: BoxShape.circle,
                              )
                            : BoxDecoration(
                                border: Border.all(color: kGrey),
                                shape: BoxShape.circle,
                              ),
                      ),
                      Container(
                        width: controller.pageIndex == 1 ? 7 : 5,
                        height: controller.pageIndex == 1 ? 7 : 5,
                        decoration: controller.pageIndex == 1
                            ? BoxDecoration(
                                color: kGrey,
                                shape: BoxShape.circle,
                              )
                            : BoxDecoration(
                                border: Border.all(color: kGrey),
                                shape: BoxShape.circle,
                              ),
                      ),
                      Container(
                        width: controller.pageIndex == 2 ? 7 : 5,
                        height: controller.pageIndex == 2 ? 7 : 5,
                        decoration: controller.pageIndex == 2
                            ? BoxDecoration(
                                color: kGrey,
                                shape: BoxShape.circle,
                              )
                            : BoxDecoration(
                                border: Border.all(color: kGrey),
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

  const _OnboardCard({
    required this.title,
    required this.content,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    return Center(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: size.width - 2 * horizontalPadding,
                height: size.width / 2 + 100,
              ),
              Container(
                width: size.width - 2 * horizontalPadding,
                height: size.width / 2 + 55,
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  margin: EdgeInsets.only(
                    left: horizontalPadding,
                    right: horizontalPadding,
                    top: 2 * horizontalPadding + 16,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: kLargeTitleStyle(
                          kBlack,
                        ),
                      ),
                      SizedBox(height: defaultSizeBoxPadding),
                      Text(
                        content,
                        textAlign: TextAlign.center,
                        style: (kContentStyleBold(kBlack)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Image(
            image: AssetImage("assets/images/brush.png"),
            width: 100,
          )
        ],
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
