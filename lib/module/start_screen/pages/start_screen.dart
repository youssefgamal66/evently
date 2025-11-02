import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently/core/const/app_assets.dart';
import 'package:evently/core/maneger/app_provider.dart';
import 'package:evently/core/routes/app_route_name.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatefulWidget {
  StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    int value = 0;
    var provider = Provider.of<AppProvider>(context);
    var theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    textDirection: TextDirection.ltr,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppAssets.small_logo),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Evently",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: theme.primaryColor,
                            fontFamily: GoogleFonts.jockeyOne().fontFamily),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  AppAssets.start_icon,
                  width: 350,
                ),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    AppLocalizations.of(context)!.start_title,
                    style: TextStyle(
                        fontSize: 25,
                        color: theme.primaryColor,
                        fontFamily: GoogleFonts.jockeyOne().fontFamily),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(AppLocalizations.of(context)!.start_desc,
                      style: theme.textTheme.bodyMedium),
                ),
                Spacer(),
                Row(textDirection: TextDirection.ltr, children: [
                  Text(
                    AppLocalizations.of(context)?.lang ?? "",
                    style: TextStyle(
                      fontSize: 22,
                      color: theme.primaryColor,
                    ),
                  ),
                  Spacer(),
                  AnimatedToggleSwitch<String>.rolling(
                    current: provider.lang,
                    values: ["en", "ar"],
                    onChanged: (value) {
                      provider.changeLang(value);
                    },
                    iconList: [
                      Image.asset(
                        AppAssets.LR_icon,
                      ),
                      Image.asset(
                        AppAssets.eg_icon,
                      ),
                    ],
                    style: ToggleStyle(
                        backgroundColor: Colors.transparent,
                        borderColor: theme.primaryColor,
                        indicatorColor: theme.primaryColor),
                    height: 40,
                    indicatorSize: Size(40, 40),
                  )
                ]),
                Spacer(),
                Row(textDirection: TextDirection.ltr, children: [
                  Text(
                    AppLocalizations.of(context)!.theme,
                    style: TextStyle(
                      fontSize: 22,
                      color: theme.primaryColor,
                    ),
                  ),
                  Spacer(),
                  AnimatedToggleSwitch<ThemeMode>.rolling(
                    current: provider.themeMode,
                    values: const [ThemeMode.light, ThemeMode.dark],
                    onChanged: (value) {
                      if (value == ThemeMode.light) {
                        provider.changeTheme("Light");
                      }
                      if (value == ThemeMode.dark) {
                        provider.changeTheme("Dark");
                      }
                    },
                    iconList: [
                      Image.asset(
                        AppAssets.Sun,
                      ),
                      Image.asset(
                        AppAssets.Moon,
                        color: provider.themeMode == ThemeMode.light
                            ? theme.primaryColor
                            : Colors.white,
                      )
                    ],
                    style: ToggleStyle(
                        backgroundColor: Colors.transparent,
                        borderColor: theme.primaryColor,
                        indicatorColor: theme.primaryColor),
                    height: 40,
                    indicatorSize: Size(40, 40),
                  )
                ]),
                Spacer(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(500, 60),
                        backgroundColor: theme.primaryColor,
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16)))),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, RouteName.OnBoarding);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.l_start,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
                Spacer(),
              ],
            )),
      ),
    );
  }
}
