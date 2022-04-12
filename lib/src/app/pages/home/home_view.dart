import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shortly/src/app/constants.dart';
import 'package:shortly/src/app/pages/home/home_controller.dart';
import 'package:shortly/src/app/texts.dart';
import 'package:shortly/src/app/widgets/default_button.dart';
import 'package:shortly/src/app/widgets/default_progress_indicator.dart';
import 'package:shortly/src/data/repositories/data_short_link_repository.dart';
import 'package:shortly/src/domain/entities/short_link.dart';

class HomeView extends View {
  @override
  State<StatefulWidget> createState() {
    return _HomeViewState(HomeController(DataShortLinkRepository()));
  }
}

class _HomeViewState extends ViewState<HomeView, HomeController> {
  _HomeViewState(HomeController controller) : super(controller);

  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;
    return Scaffold(
      key: globalKey,
      body: ControlledWidgetBuilder<HomeController>(
        builder: (context, controller) {
          return Column(
            children: [
              Expanded(
                child: controller.shortLinks == null ||
                        controller.shortLinks!.isEmpty
                    ? Stack(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: padding.top + 50),
                                const Image(
                                  image: AssetImage("assets/icons/shortly.png"),
                                ),
                                const Image(
                                  image: AssetImage("assets/images/main.png"),
                                ),
                                Center(
                                  child: SizedBox(
                                    width: size.width / 2 + 40,
                                    child: Column(
                                      children: [
                                        Text(
                                          ShortlyTexts.letsGetStarted,
                                          textAlign: TextAlign.center,
                                          style: kLargeTitleStyle(kBlack),
                                        ),
                                        const SizedBox(
                                            height: defaultSizeBoxPadding),
                                        Text(
                                          ShortlyTexts.pasteLink,
                                          textAlign: TextAlign.center,
                                          style: kTitleStyle(kBlack),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          controller.isAddButtonPressed
                              ? Center(
                                  child: DefaultProgressIndicator(
                                    color: kSecondaryColor,
                                  ),
                                )
                              : Center(
                                  child: Container(),
                                ),
                        ],
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: padding.top + 20),
                            Text(
                              ShortlyTexts.yourLinkHistory,
                              style: kTitleStyle(kBlack),
                            ),
                            for (int i = 0;
                                i < controller.shortLinks!.length;
                                i++)
                              Column(
                                children: [
                                  SizedBox(height: 2 * defaultSizeBoxPadding),
                                  _ShortLinkContainer(
                                    shortLink: controller.shortLinks![i],
                                    fullLink: controller.fullLinks[i],
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
              ),
              Container(
                width: size.width,
                color: kSecondaryColor,
                height: size.width / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: size.width - 5 * horizontalPadding,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: kBackGroundColor,
                      ),
                      child: TextFormField(
                        controller: controller.editingController,
                        textAlign: TextAlign.center,
                        onChanged: (value) =>
                            controller.onUrlTextFormFieldChanged(value),
                        cursorColor: kPrimaryColor,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: ShortlyTexts.shortenAlinkHere,
                          hintStyle: kHintTextStyle(kGrey),
                        ),
                      ),
                    ),
                    const SizedBox(height: defaultSizeBoxPadding),
                    Container(
                      width: size.width - 5 * horizontalPadding,
                      child: DefaultButton(
                        onPressed:
                            controller.url != null && controller.url!.isNotEmpty
                                ? () => controller.onShortenItButtonPressed()
                                : null,
                        text: ShortlyTexts.shortenIt,
                        color:
                            controller.url != null && controller.url!.isNotEmpty
                                ? kPrimaryColor
                                : kDisabledButtonColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ShortLinkContainer extends StatelessWidget {
  final ShortLink shortLink;
  final String fullLink;

  _ShortLinkContainer({
    required this.shortLink,
    required this.fullLink,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ControlledWidgetBuilder<HomeController>(
      builder: (context, controller) {
        return Container(
          width: size.width - 2 * horizontalPadding,
          height: size.width / 2 - 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kWhite,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: horizontalPadding,
                  left: horizontalPadding,
                  right: horizontalPadding,
                ),
                child: Row(
                  children: [
                    Container(
                      width: size.width - 6 * horizontalPadding,
                      child: Text(
                        fullLink,
                        style: kContentStyleBold(kBlack),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.removeShortLinkFromHistory(shortLink.id);
                      },
                      child: Icon(
                        Icons.delete,
                        color: kBlack,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                color: kBlack,
              ),
              Container(
                padding: EdgeInsets.only(
                  left: horizontalPadding,
                  right: horizontalPadding,
                ),
                width: size.width - 6 * horizontalPadding,
                child: Text(
                  shortLink.fullShortLink,
                  style: kContentStyleBold(kPrimaryColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 2 * defaultSizeBoxPadding),
              Container(
                padding: EdgeInsets.only(
                  left: horizontalPadding,
                  right: horizontalPadding,
                ),
                height: 40,
                child: DefaultButton(
                  onPressed: () async {
                    controller.copyItemToClipboard(shortLink);
                  },
                  text: shortLink.isCopied
                      ? ShortlyTexts.copied
                      : ShortlyTexts.copy,
                  color: shortLink.isCopied ? kSecondaryColor : kPrimaryColor,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
