import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/main.dart';
import 'package:prokit_flutter/main/utils/AppColors.dart';
import 'package:prokit_flutter/main/utils/AppWidget.dart';
import 'package:prokit_flutter/workingApps/chatGPT/utils/colors.dart';
import 'package:prokit_flutter/workingApps/chatGPT/utils/constant.dart';

import '../../../main/utils/AppConstant.dart';
import '../utils/common.dart';

class ChatGPTSettingScreen extends StatefulWidget {
  @override
  _ChatGPTSettingScreenState createState() => _ChatGPTSettingScreenState();
}

class _ChatGPTSettingScreenState extends State<ChatGPTSettingScreen> {
  TextEditingController tokenController = TextEditingController();

  InterstitialAd? interstitialAd;
  BannerAd? myBanner;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    tokenController.text = getStringAsync(CHAT_GPT_API_KEY, defaultValue: API_KEY);

    if (isMobile) {
      _createInterstitialAd();

      myBanner = loadBannerAd()..load();
    }
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: InterstitialAdIdForAndroidRelease,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print('$ad loaded');
          interstitialAd = ad;
          interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error.');
          interstitialAd = null;
          _createInterstitialAd();
        },
      ),
      request: AdRequest(),
    );
  }

  void _showInterstitialAd() {
    if (interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) => print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    interstitialAd!.show();
    interstitialAd = null;
  }

  BannerAd loadBannerAd() {
    return BannerAd(
      adUnitId: getBannerAdUnitId()!,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(onAdLoaded: (ad) {
        setState(() {});
      }),
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    interstitialAd?.dispose();

    myBanner?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('ChatGPT Setting Screen', color: appStore.isDarkModeOn ? replyMsgBgColor : Colors.white),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ChatGPT Token', style: primaryTextStyle()),
                16.height,
                AppTextField(
                  controller: tokenController,
                  textFieldType: TextFieldType.OTHER,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 5,
                  decoration: inputDecoration(
                    context,
                    label: 'Enter Token',
                    labelText: 'Enter Token',
                    borderColor: appColorPrimary,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ).copyWith(fillColor: appColorPrimary.withAlpha(30)),
                ),
                30.height,
                AppButton(
                  color: appColorPrimary,
                  width: 100,
                  onTap: () async {
                    setValue(CHAT_GPT_API_KEY, tokenController.text);
                    toast('Successfully Save...');
                    await Future.delayed(Duration(seconds: 2));
                    _showInterstitialAd();
                    finish(context, true);
                  },
                  child: Text('Save', style: boldTextStyle(color: Colors.white)),
                ).center(),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: isMobile ? AdWidget(ad: myBanner!).withSize(width: context.width(), height: 50) : Offstage(),
          ),
        ],
      ),
    );
  }
}
