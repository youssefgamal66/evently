import 'package:evently/core/const/app_assets.dart';
import 'package:evently/core/maneger/app_provider.dart';
import 'package:evently/core/routes/app_route_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appProvider = Provider.of<AppProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
          ),
          toolbarHeight: 180,
          backgroundColor: theme.primaryColor,
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              textDirection: TextDirection.ltr,
              children: [
                Image.asset(
                  AppAssets.route,
                  width: 120,
                  height: 120,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    textDirection: TextDirection.ltr,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        FirebaseAuth.instance.currentUser?.displayName
                                ?.toUpperCase() ??
                            "",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        FirebaseAuth.instance.currentUser?.email ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Language',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.primaryColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    style: TextStyle(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    iconSize: 40,
                    iconEnabledColor: theme.primaryColor,
                    value: appProvider.lang,
                    items: [
                      DropdownMenuItem(value: 'ar', child: Text('Arabic')),
                      DropdownMenuItem(value: 'en', child: Text('English')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        appProvider.changeLang(value);
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  'Theme',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.primaryColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    style: TextStyle(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    iconSize: 40,
                    iconEnabledColor: theme.primaryColor,
                    value: appProvider.themeMode.name,
                    items: [
                      DropdownMenuItem(
                          value: 'light', child: Text('Light Mode')),
                      DropdownMenuItem(value: 'dark', child: Text('Dark Mode')),
                    ],
                    onChanged: (value) {
                      appProvider.changeTheme(value!);
                    },
                  ),
                ),
              ),
              Spacer(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(500, 60),
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)))),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacementNamed(context, RouteName.Login);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Logout",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  )),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
