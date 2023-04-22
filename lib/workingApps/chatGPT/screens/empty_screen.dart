import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/main.dart';
import 'package:prokit_flutter/workingApps/chatGPT/utils/colors.dart';

import '../../../main/utils/AppColors.dart';

class EmptyScreen extends StatefulWidget {
  final Function(String value) onTap;

  EmptyScreen({Key? key, required this.onTap}) : super(key: key);

  @override
  State<EmptyScreen> createState() => _EmptyScreenState();
}

class _EmptyScreenState extends State<EmptyScreen> {
  List<String> questionList = [
    'Explain quantum computing in simple terms ?',
    'Got any creative ideas for a 10 year old’s birthday ?',
    'How do I make an HTTP request in Javascript ?',
  ];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text('Iqonic Bot', style: boldTextStyle(size: 34)),
          8.height,
          RichTextWidget(
            list: [
              TextSpan(text: 'powered by ', style: secondaryTextStyle()),
              TextSpan(text: 'ChatGPT', style: boldTextStyle(size: 24)),
            ],
          ),
          30.height,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.light_mode_outlined, size: 30),
              16.width,
              Text('Examples', style: boldTextStyle(size: 20)),
            ],
          ),
          32.height,
          Wrap(
            runSpacing: 16,
            children: List.generate(questionList.length, (index) {
              return GestureDetector(
                onTap: () {
                  widget.onTap.call(questionList[index]);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: boxDecorationDefault(
                    color: appStore.isDarkModeOn ? replyMsgBgColor.withAlpha(50) : Colors.white.withAlpha(50),
                    borderRadius: radius(),
                  ),
                  child: Row(
                    children: [
                      Text(questionList[index], style: primaryTextStyle(color: appStore.isDarkModeOn ? Colors.white : appColorPrimary)).expand(),
                      16.width,
                      Icon(Icons.arrow_forward_ios, color: appStore.isDarkModeOn ? Colors.white : appColorPrimary, size: 16),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
