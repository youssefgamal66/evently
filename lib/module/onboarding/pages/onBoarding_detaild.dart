import 'package:evently/core/const/app_assets.dart';
import 'package:evently/core/maneger/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnBoarding_detaild {
  // var provider = Provider.of<AppProvider>(context);
  String? photo;
  String? Title;
  String? Text;

  OnBoarding_detaild(
      {required this.photo, required this.Title, required this.Text});

 static List<OnBoarding_detaild> iteams=[
   OnBoarding_detaild(photo: AppAssets.sec_icon, Title: "Find Events That Inspire You", Text: "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you."),
   OnBoarding_detaild(photo: AppAssets.third_icon, Title: "Effortless Event Planning", Text: "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests."),
   OnBoarding_detaild(photo: AppAssets.Last_icon, Title: "Connect with Friends & Share Moments", Text: "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.")
 ];
}
