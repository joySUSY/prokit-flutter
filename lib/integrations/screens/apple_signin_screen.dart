import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/main.dart';
import 'package:prokit_flutter/main/utils/AppConstant.dart';
import 'package:prokit_flutter/main/utils/AppWidget.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class AppleSignInScreen extends StatefulWidget {
  @override
  _AppleSignInScreenState createState() => _AppleSignInScreenState();
}

class _AppleSignInScreenState extends State<AppleSignInScreen> {

  String email = "";
  String username = "";

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    changeStatusColor(appStore.scaffoldBackground!);
    TheAppleSignIn.onCredentialRevoked!.listen((_) {
      print("Credentials revoked");
    });
  }

  // region Apple Sign
  Future<void> appleSignIn() async {
    if (await TheAppleSignIn.isAvailable()) {
      AuthorizationResult result = await TheAppleSignIn.performRequests([
        AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);

      switch (result.status) {
        case AuthorizationStatus.authorized:
          final appleIdCredential = result.credential!;
          final oAuthProvider = OAuthProvider('apple.com');
          final credential = oAuthProvider.credential(
            idToken: String.fromCharCodes(appleIdCredential.identityToken!),
            accessToken: String.fromCharCodes(appleIdCredential.authorizationCode!),
          );

          final authResult = await FirebaseAuth.instance.signInWithCredential(credential);
          final user = authResult.user!;

          log('User:- $user');

          if (result.credential!.email != null) {
            await setValue(APPLE_EMAIL, result.credential!.email);
            await setValue(APPLE_GIVE_NAME, result.credential!.fullName!.givenName);
            await setValue(APPLE_FAMILY_NAME, result.credential!.fullName!.familyName);
            await setValue(IS_LOGGED_IN,true);

            email = getStringAsync(APPLE_EMAIL);
            username = getStringAsync(APPLE_GIVE_NAME);

            toast('Login Successfully');
          } else {
            log('Email:- ${getStringAsync(APPLE_EMAIL)}');
            log('appleGivenName:- ${getStringAsync(APPLE_GIVE_NAME)}');
            log('appleFamilyName:- ${getStringAsync(APPLE_FAMILY_NAME)}');

            if (!getStringAsync(APPLE_EMAIL).isEmptyOrNull) {
              await setValue(IS_LOGGED_IN,true);

              email = getStringAsync(APPLE_EMAIL);
              username = getStringAsync(APPLE_GIVE_NAME);
              toast('Login Successfully');
            } else {
              await setValue(IS_LOGGED_IN,false);
              throw 'Add Your Apple Email ID';
            }
          }

          setState(() {});

          break;
        case AuthorizationStatus.error:
          throw ("Sign in failed: ${result.error!.localizedDescription}");
        case AuthorizationStatus.cancelled:
          throw ('User cancelled');
      }
    } else {
      throw 'Apple Sign In is not available';
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'Apple Sign In'),
      body: Observer(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (getBoolAsync(IS_LOGGED_IN))
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('User Email', style: primaryTextStyle()),
                    8.height,
                    Text(email.validate(), style: boldTextStyle()),
                    16.height,
                    Text('User Name', style: primaryTextStyle()),
                    8.height,
                    Text(username.validate(), style: boldTextStyle()),
                  ],
                ).paddingSymmetric(horizontal: 16,vertical: 16),
              16.height,
              if (isIOS && !getBoolAsync(IS_LOGGED_IN))
                AppButton(
                  text: '',
                  color: black,
                  textStyle: boldTextStyle(),
                  width: context.width() - context.navigationBarHeight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.apple,color: white),
                      4.width,
                      Text('Sign in with Apple', style: boldTextStyle(size: 14,color: white), textAlign: TextAlign.center),
                    ],
                  ),
                  onTap: () {
                    appleSignIn();
                  },
                ).paddingSymmetric(horizontal: 16,vertical: 16),
              if (isIOS && getBoolAsync(IS_LOGGED_IN))
                AppButton(
                  text: 'Sign Out',
                  color: context.primaryColor,
                  textStyle: boldTextStyle(color: white),
                  width: context.width() - context.navigationBarHeight,
                  onTap: () async{
                    email = "";
                    username = "";
                    await removeKey(IS_LOGGED_IN);
                    toast('Logout Successfully');
                    finish(context);
                  },
                ).paddingSymmetric(horizontal: 16,vertical: 16),
            ],
          );
        }
      ),
    );
  }
}
