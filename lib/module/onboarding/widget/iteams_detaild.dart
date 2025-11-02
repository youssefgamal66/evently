import 'package:evently/module/onboarding/pages/onBoarding_detaild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IteamsDetaild extends StatelessWidget {
  final OnBoarding_detaild items;
  IteamsDetaild({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            Image.asset(
              items.photo!,
              width: 350,
            ),
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                items.Title!,
                style: TextStyle(
                    fontSize: 25,
                    color: theme.primaryColor,
                    fontFamily: GoogleFonts.jockeyOne().fontFamily),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              items.Text!,
                style: theme.textTheme.bodyMedium
            ),
          ],
        ),
      ),
    );
  }
}
