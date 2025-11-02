import 'package:evently/core/const/app_assets.dart';
import 'package:evently/core/routes/app_route_name.dart';
import 'package:evently/module/event/pages/event_details.dart';
import 'package:evently/module/layout/manager/layout_provider.dart';
import 'package:evently/module/layout/widget/category.dart';
import 'package:evently/module/layout/widget/event_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LayoutProvider>(context, listen: false)
          .getEventsStream("All");
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Consumer<LayoutProvider>(
      builder: (context, provider, child) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              toolbarHeight: 180,
              backgroundColor: theme.primaryColor,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(top: 10.0, right: 10, left: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Welcome Back ",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              FirebaseAuth.instance.currentUser?.displayName
                                      ?.toUpperCase() ??
                                  "",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Image.asset(AppAssets.Sunicon),
                        const SizedBox(width: 10),
                        Image.asset(AppAssets.langicon),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: const [
                        Icon(Icons.location_on_outlined, color: Colors.white),
                        Text("Cairo,", style: TextStyle(color: Colors.white)),
                        Text("Egypt", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    DefaultTabController(
                      initialIndex: provider.selectedTapIndex,
                      length: Category.items.length,
                      child: TabBar(
                          indicatorPadding: EdgeInsets.zero,
                          indicatorColor: Colors.transparent,
                          dividerColor: Colors.transparent,
                          labelColor: theme.primaryColor,
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          labelPadding: const EdgeInsets.all(4),
                          onTap: provider.ChangeTapIndex,
                          tabs: [
                            Tab(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 4),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: provider.selectedTapIndex == 0
                                          ? Colors.white
                                          : Colors.white60),
                                  borderRadius: BorderRadius.circular(16),
                                  color: provider.selectedTapIndex == 0
                                      ? Colors.white
                                      : Colors.transparent,
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      AppAssets.byc,
                                      color: provider.selectedTapIndex == 0
                                          ? theme.primaryColor
                                          : Colors.white,
                                      width: 12,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      'All',
                                      style: TextStyle(
                                        color: provider.selectedTapIndex == 0
                                            ? theme.primaryColor
                                            : Colors.white,
                                        fontSize: 10,
                                        fontWeight: provider.selectedTapIndex == 0
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ...List.generate(Category.items.length - 1, (index) {
                              final item = Category.items[index];
                              final isSelected =
                                  provider.selectedTapIndex == index + 1;
          
                              return Tab(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 4),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: provider.selectedTapIndex == 0
                                            ? Colors.white
                                            : Colors.white60),
                                    borderRadius: BorderRadius.circular(16),
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.transparent,
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        item.photo,
                                        color: isSelected
                                            ? theme.primaryColor
                                            : Colors.white,
                                        width: 12,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        item.text ?? '',
                                        style: TextStyle(
                                          color: isSelected
                                              ? theme.primaryColor
                                              : Colors.white,
                                          fontSize: 10,
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ]),
                    )
                  ],
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.events.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Eventdetails(
                                    event: provider.events[index],
                                  ),
                                ));
                          },
                          child: EventCard(event: provider.events[index]));
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
