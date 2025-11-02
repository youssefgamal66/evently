import 'package:evently/core/const/app_assets.dart';
import 'package:evently/core/routes/app_route_name.dart';
import 'package:evently/module/layout/manager/layout_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (context) => LayoutProvider(),
      child: Consumer<LayoutProvider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: Scaffold(
              body: provider.screens[provider.selectedIndex],
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.addEvent);

                },
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 5,
                    ),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
              bottomNavigationBar: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: theme.primaryColor,
                ),
                child: BottomNavigationBar(
                  currentIndex: provider.selectedIndex,
                  onTap: provider.ChangeNavIndex,
                  showUnselectedLabels: true,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.white.withOpacity(0.7),
                  type: BottomNavigationBarType.fixed,
                  items: [
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(AppAssets.unHome),
                      label: "Home",
                      activeIcon: SvgPicture.asset(AppAssets.Home),
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(AppAssets.unMap),
                      label: "Map",
                      activeIcon: SvgPicture.asset(AppAssets.Map),
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(AppAssets.unHeart),
                      label: "Love",
                      activeIcon: SvgPicture.asset(AppAssets.Heart),
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(AppAssets.unUser),
                      label: "Profile",
                      activeIcon: SvgPicture.asset(AppAssets.User),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
