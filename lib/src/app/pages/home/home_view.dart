import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shortly/src/app/constants.dart';
import 'package:shortly/src/app/pages/home/home_controller.dart';
import 'package:shortly/src/data/repositories/data_short_link_repository.dart';

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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: ControlledWidgetBuilder<HomeController>(
                builder: (context, controller) {
                  return Column(
                    children: [
                      SizedBox(height: padding.top + 20),
                      Container(
                        width: size.width,
                        height: 75,
                        child: TextFormField(
                          onChanged: ((value) =>
                              controller.onUrlTextFormFieldChanged(value)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.addShortLinkToHistoryList();
                        },
                        child: Container(
                          color: kPrimaryColor,
                          width: 100,
                          height: 56,
                          child: Text("add"),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
