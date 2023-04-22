import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/fullApps/dating/utils/DAWidgets.dart';
import 'package:prokit_flutter/webApps/portfolios/utils/Images.dart';

class TestimonialWidget extends StatefulWidget {
  static String tag = '/TestimonialWidget';

  @override
  TestimonialWidgetState createState() => TestimonialWidgetState();
}

class TestimonialWidgetState extends State<TestimonialWidget> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: Container(
        margin: EdgeInsets.only(top: 32, bottom: 32),
        child: Stack(
          children: [
            commonCachedNetworkImage(
              p2GalleryImg6,
              fit: BoxFit.cover,
              height: 300,
              width: context.width(),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              width: context.width(),
              height: context.height() * 0.5,
              color: Colors.black.withOpacity(0.75),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "ProKit – Biggest Flutter UI kit is the ultimate library of Flutter UI templates combined into a high-quality Flutter UI kit for Android/iOS "
                      "developers. The collection consists of UI elements and styles based on Material Design Guidelines. ",
                      style: boldTextStyle(size: 22, color: Colors.white),
                    ).paddingOnly(left: 16, right: 16),
                    16.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        commonCachedNetworkImage(
                          p2User,
                          height: 80,
                        ).cornerRadiusWithClipRRect(60),
                        8.width,
                        Column(
                          children: [
                            Text('christopher robin', style: boldTextStyle(size: 20, color: Colors.white)),
                            4.height,
                            Text('- UI/UX Designer', style: secondaryTextStyle(size: 20, color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ).paddingOnly(top: 16),
              ],
            ),
          ],
        ),
      ),
      tablet: Container(
        height: 300,
        margin: EdgeInsets.only(top: 32, bottom: 32),
        child: Stack(
          children: [
            commonCachedNetworkImage(
              p2GalleryImg6,
              fit: BoxFit.cover,
              height: 300,
              width: context.width(),
            ),
            Container(width: context.width(), height: 300, color: Colors.black.withOpacity(0.75)),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ProKit – Biggest Flutter UI kit is the ultimate library of Flutter UI templates combined into "
                    "a high-quality Flutter UI kit for Android/iOS developers. ",
                    style: boldTextStyle(size: 28, color: Colors.white),
                    maxLines: 4,
                  ).expand(flex: 1),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      commonCachedNetworkImage(
                        p2User,
                        height: 120,
                      ).cornerRadiusWithClipRRect(60),
                      8.height,
                      Text('christopher robin', style: boldTextStyle(size: 20, color: Colors.white)),
                      4.height,
                      Text('- UI/UX Designer', style: secondaryTextStyle(size: 20, color: Colors.white)),
                    ],
                  ).expand(flex: 1),
                ],
              ).withWidth(context.width() * 0.8),
            ),
          ],
        ),
      ),
      web: Container(
        height: 300,
        margin: EdgeInsets.only(top: 32, bottom: 32),
        child: Stack(
          children: [
            commonCachedNetworkImage(
              p2GalleryImg6,
              fit: BoxFit.cover,
              height: 300,
              width: context.width(),
            ),
            Container(width: context.width(), height: 300, color: Colors.black.withOpacity(0.75)),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ProKit – Biggest Flutter UI kit is the ultimate library of Flutter UI templates "
                    "combined into a high-quality Flutter UI kit for Android/iOS developers. ",
                    style: boldTextStyle(size: 28, color: Colors.white),
                    maxLines: 4,
                  ).expand(flex: 1),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      commonCachedNetworkImage(
                        p2User,
                        height: 120,
                      ).cornerRadiusWithClipRRect(60),
                      8.height,
                      Text('christopher robin', style: boldTextStyle(size: 20, color: Colors.white)),
                      4.height,
                      Text('- UI/UX Designer', style: secondaryTextStyle(size: 20, color: Colors.white)),
                    ],
                  ).expand(flex: 1),
                ],
              ).withWidth(context.width() * 0.8),
            ),
          ],
        ),
      ),
    );
  }
}
