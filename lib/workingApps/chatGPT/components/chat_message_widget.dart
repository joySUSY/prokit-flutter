import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/main.dart';
import 'package:prokit_flutter/themes/theme14/utils/T14Colors.dart';
import 'package:prokit_flutter/workingApps/chatGPT/models/question_answer_model.dart';
import 'package:prokit_flutter/workingApps/chatGPT/utils/colors.dart';
import 'package:prokit_flutter/workingApps/chatGPT/utils/common.dart';
import 'package:prokit_flutter/workingApps/chatGPT/utils/images.dart';
import 'package:share_plus/share_plus.dart';

import '../../../main/utils/AppColors.dart';

class ChatMessageWidget extends StatefulWidget {
  final String answer;
  final QuestionAnswerModel data;
  final bool isLoading;

  ChatMessageWidget({required this.answer, required this.data, required this.isLoading});

  @override
  State<ChatMessageWidget> createState() => _ChatMessageWidgetState();
}

class _ChatMessageWidgetState extends State<ChatMessageWidget> {
  FlutterTts flutterTts = FlutterTts();

  bool isSpeak = false;
  bool isShare = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void botSpeak({required String text}) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5); //speed of speech
    await flutterTts.setVolume(1.0); //volume of speech
    await flutterTts.setPitch(1); //pitch of sound

    if (text.isNotEmpty) {
      await flutterTts.speak(text);
    }
  }

  void share(BuildContext context, {String? question, String? answer}) {
    getPackageInfo().then((value) async {
      await Share.share(
        'Q: ${question.validate()}\nChatGPT: ${answer.validate()}',
      );
    });
  }

  Widget speakIconWidget() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: decoration(
          color: appStore.isDarkModeOn
              ? Colors.white
              : isSpeak
                  ? Colors.white
                  : Colors.white.withAlpha(40)),
      child: Image.asset(
        ic_speak,
        height: 14,
        width: 14,
        color: appStore.isDarkModeOn
            ? Colors.white
            : isSpeak
                ? appColorPrimary
                : Colors.white,
      ),
    ).onTap(() {
      if (isSpeak)
        flutterTts.stop();
      else
        botSpeak(text: widget.answer);
      isSpeak = !isSpeak;

      setState(() {});
    });
  }

  Widget shareIconWidget() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: decoration(color: Colors.white.withAlpha(40)),
      child: Icon(Icons.share, size: 14, color: Colors.white),
    ).onTap(() {
      share(context, question: widget.data.question, answer: widget.answer);
    });
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          margin: EdgeInsets.only(top: 3.0, bottom: 3.0, right: 0, left: (500 * 0.10).toDouble()),
          decoration: boxDecorationDefault(
            color: appStore.isDarkModeOn ? appColorPrimary : Colors.white,
            boxShadow: defaultBoxShadow(blurRadius: 0, shadowColor: Colors.transparent),
            borderRadius: radiusOnly(bottomLeft: 16, topLeft: 16, topRight: 16),
          ),
          child: Text('Q: ${widget.data.question}', style: primaryTextStyle(size: 14)),
        ),
        16.height,
        if (widget.answer.isEmpty && widget.isLoading) Center(child: SpinKitThreeBounce(color: t14_TextField_BgColor, size: 20)),
        if (widget.answer.isNotEmpty && !widget.isLoading)
          Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  margin: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 0, right: (500 * 0.14).toDouble()),
                  decoration: boxDecorationDefault(
                    color: appStore.isDarkModeOn ? replyMsgBgColor : appColorPrimary,
                    boxShadow: defaultBoxShadow(blurRadius: 0, shadowColor: Colors.transparent),
                    borderRadius: radiusOnly(topLeft: 16, bottomRight: 16, topRight: 16),
                  ),
                  child: Column(
                    children: [
                      Text('Ans: ${widget.answer}', style: primaryTextStyle(size: 14, color: Colors.white)),
                      8.height,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${widget.answer.calculateReadTime().toStringAsFixed(1).toDouble().ceil()} min read",
                            style: secondaryTextStyle(color: Colors.white54, size: 12),
                          ),
                          Spacer(),
                          shareIconWidget(),
                          8.width,
                          speakIconWidget(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 25,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: decoration(),
                      child: Icon(Icons.copy, size: 16, color: appStore.isDarkModeOn ? Colors.white : appColorPrimary),
                    ).onTap(() {
                      widget.answer.copyToClipboard();
                      toast('Copied to Clipboard');
                    }),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}
