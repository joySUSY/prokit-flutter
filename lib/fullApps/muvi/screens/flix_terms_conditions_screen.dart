import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/fullApps/muvi/utils/flix_app_widgets.dart';
import 'package:prokit_flutter/fullApps/muvi/utils/resources/flix_colors.dart';
import 'package:prokit_flutter/fullApps/muvi/utils/resources/flix_size.dart';
import '../../../main/utils/AppConstant.dart';


class TermsConditionsScreen extends StatefulWidget {
  static String tag = '/TermsConditionsSceen';

  @override
  TermsConditionsScreenState createState() => TermsConditionsScreenState();
}

class TermsConditionsScreenState extends State<TermsConditionsScreen> {
  @override
  void initState() {
    super.initState();
    setStatusBarColor(muvi_navigationBackground, statusBarIconBrightness: Brightness.light);
  }

  @override
  void dispose() {
    super.dispose();
    setStatusBarColor(muvi_navigationBackground, statusBarIconBrightness: Brightness.light);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: muvi_appBackground,
        appBar: appBarLayout(context, "Terms & Conditions"),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Flix- Terms & conditions',
                style: boldTextStyle(color: Colors.white, size: 18),
              ).paddingBottom(spacing_standard),
              Text(
                ProKitSoLongText,
                style: secondaryTextStyle(color: muvi_textColorSecondary),
              )
            ],
          ).paddingAll(spacing_standard_new),
        ),
      ),
    );
  }
}
