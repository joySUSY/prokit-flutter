import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/main.dart';
import 'package:prokit_flutter/main/screens/ProKitLauncher.dart';
import 'package:prokit_flutter/main/utils/AppWidget.dart';
import 'package:prokit_flutter/themes/theme4/utils/T4Colors.dart';

import 'T4Constant.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.isAntiAlias = true; // Create a brush and configure its properties
    paint.color = Color(0x77cdb175); // brush color

    var max = size.width; // size gets to width
    var dashWidth = 5;
    var dashSpace = 5;
    double startX = 0;
    final space = (dashSpace + dashWidth);

    while (startX < max) {
      canvas.drawLine(Offset(startX, 100.0), Offset(startX + dashWidth, 100.0), paint);
      startX += space;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// ignore: must_be_immutable
class TopBar extends StatefulWidget {
  var titleName;
  final bool isDirect;

  TopBar(var this.titleName, {this.isDirect = false});

  @override
  State<StatefulWidget> createState() {
    return TopBarState(isDirect: isDirect);
  }
}

class TopBarState extends State<TopBar> {
  final bool isDirect;

  TopBarState({this.isDirect = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        color: appStore.appBarColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu, color: appStore.iconColor),
              onPressed: () {
                if (isDirect) {
                  ProKitLauncher().launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
                } else {
                  finish(context);
                }
              },
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Center(
                child: text(widget.titleName, textColor: appStore.textPrimaryColor, fontSize: textSizeNormal, fontFamily: fontBold),
              ),
            ),
            IconButton(
              icon: Icon(Icons.notifications_none),
              onPressed: () {
                finish(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

Widget ring(String description) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150.0),
          border: Border.all(
            width: 16.0,
            color: t4_colorPrimary,
          ),
        ),
      ),
      SizedBox(height: 16),
      text(description, textColor: appStore.textPrimaryColor, fontSize: textSizeNormal, fontFamily: fontSemibold, isCentered: true, maxLine: 2)
    ],
  );
}
