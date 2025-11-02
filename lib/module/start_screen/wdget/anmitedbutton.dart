import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Anmitedbutton extends StatefulWidget {
  String? photo1;
  String? photo2;

   Anmitedbutton({super.key,required this.photo1,required this.photo2});

  @override
  State<Anmitedbutton> createState() => _AnmitedbuttonState();
}

class _AnmitedbuttonState extends State<Anmitedbutton> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return  AnimatedToggleSwitch<int>.rolling(

      current: value,
      values: const [0, 1],
      onChanged: (i) => setState(() => value = i),
      iconBuilder: (value, foreground) {
        switch (value) {
          case 0:
            return Image.asset(widget.photo1!);
          default:
            return Image.asset(widget.photo2!);
        }
      },
      style: ToggleStyle(
          backgroundColor: Colors.transparent,
          borderColor: theme.primaryColor,
          indicatorColor: theme.primaryColor),
      height: 40,
      indicatorSize: Size(40, 40),
    );
  }
}
