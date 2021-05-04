import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:widget_lib/widget_lib.dart';
import 'package:widget_lib/widgets/platform_specific/widgets/platform_flat_button.dart';
import 'package:widget_lib/widgets/theme_widget/widgets/theme_text_filed.dart';
import 'package:widget_lib/widgets/utils/widget_util.dart';

class SignUp extends StatelessWidget {
  final Function onLogin;
  final Function onSignUp;
  final bool forceMaterial;

  SignUp({
    @required this.onLogin,
    @required this.onSignUp,
    this.forceMaterial,
  });

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final width = MediaQuery.of(context).size.width;
    int delay = 0;

    int getDelay({bool increase = true}) {
      if (increase) {
        delay = delay + 300;
      }
      return delay;
    }

    final bool darkMode = WidgetUtil.isDarkMode(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DelayedAnimation(
            child: ThemeText(
              'Signup',
              style: GoogleFonts.ebGaramond(
                color: !darkMode ? primaryColor : CupertinoColors.white,
                fontSize: 50,
              ),
            ),
            delay: getDelay(),
          ),
          SizedBox(height: width * 0.05),
          Container(
            height: width * 0.8,
            width: width * 0.87,
            child: DelayedAnimation(
              delay: getDelay(),
              child: ThemeCard(
                darkColor: const Color(0xff353535),
                lightColor: CupertinoColors.white,
                elevation: width * 0.01,
                borderRadius: width * 0.07,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: width * 0.01),
                      DelayedAnimation(
                        child: Container(
                          height: width * 0.1,
                          child: ThemeTextField(
                            forceMaterial: this.forceMaterial,
                            placeHolder: 'Username',
                            darkTextStyle: TextStyle(
                              color: CupertinoColors.white.withAlpha(150),
                              fontSize: width * 0.04,
                            ),
                            lightTextStyle: TextStyle(
                              color: CupertinoColors.systemGrey,
                              fontSize: width * 0.04,
                            ),
                            radius: width * 0.035,
                            insidePadding: width * 0.01,
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.015),
                              child: Icon(
                                CupertinoIcons.person_crop_circle,
                                color: darkMode
                                    ? CupertinoColors.white.withAlpha(180)
                                    : Colors.blueGrey,
                                size: width * 0.07,
                              ),
                            ),
                          ),
                        ),
                        delay: getDelay(),
                      ),
                      DelayedAnimation(
                        child: Container(
                          height: width * 0.1,
                          child: ThemeTextField(
                            forceMaterial: this.forceMaterial,
                            placeHolder: 'Password',
                            darkTextStyle: TextStyle(
                              color: CupertinoColors.white.withAlpha(150),
                              fontSize: width * 0.04,
                            ),
                            lightTextStyle: TextStyle(
                              color: CupertinoColors.systemGrey,
                              fontSize: width * 0.04,
                            ),
                            radius: width * 0.035,
                            insidePadding: width * 0.01,
                            obscureText: true,
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.015),
                              child: Icon(
                                CupertinoIcons.lock_slash_fill,
                                color: darkMode
                                    ? CupertinoColors.white.withAlpha(180)
                                    : Colors.blueGrey,
                                size: width * 0.07,
                              ),
                            ),
                          ),
                        ),
                        delay: getDelay(increase: false),
                      ),
                      DelayedAnimation(
                        child: Container(
                          height: width * 0.1,
                          child: ThemeTextField(
                            forceMaterial: this.forceMaterial,
                            placeHolder: 'Confirm Password',
                            darkTextStyle: TextStyle(
                              color: CupertinoColors.white.withAlpha(150),
                              fontSize: width * 0.04,
                            ),
                            lightTextStyle: TextStyle(
                              color: CupertinoColors.systemGrey,
                              fontSize: width * 0.04,
                            ),
                            radius: width * 0.035,
                            insidePadding: width * 0.01,
                            obscureText: true,
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.015),
                              child: Icon(
                                CupertinoIcons.lock_slash_fill,
                                color: darkMode
                                    ? CupertinoColors.white.withAlpha(180)
                                    : Colors.blueGrey,
                                size: width * 0.07,
                              ),
                            ),
                          ),
                        ),
                        delay: getDelay(increase: false),
                      ),
                      SizedBox(height: width * 0.01),
                      DelayedAnimation(
                        child: PlatformRaisedButton(
                          forceMaterial: this.forceMaterial,
                          height: width * 0.09,
                          width: width * 0.3,
                          radius: width * 0.03,
                          elevation: width * 0.025,
                          color: darkMode
                              ? CupertinoColors.systemGrey2
                              : primaryColor,
                          child: Text(
                            'Signup',
                            style: TextStyle(
                              color: darkMode ? CupertinoColors.white : null,
                              fontSize: width * 0.045,
                            ),
                          ),
                          onPressed: onSignUp,
                        ),
                        delay: getDelay(),
                      ),
                      DelayedAnimation(
                        child: PlatformFlatButton(
                          forceMaterial: this.forceMaterial,
                          height: width * 0.06,
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: darkMode
                                  ? CupertinoColors.white.withAlpha(180)
                                  : primaryColor,
                              fontSize: width * 0.045,
                            ),
                          ),
                          onPressed: onLogin,
                        ),
                        delay: getDelay(increase: false),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
