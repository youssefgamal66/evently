import 'package:evently/core/app_theme/app_color.dart';
import 'package:evently/core/const/app_assets.dart';
import 'package:evently/module/auth/widget/cust_text_form.dart';
import 'package:evently/module/event/manger/event_provider.dart';
import 'package:evently/module/layout/manager/layout_provider.dart';
import 'package:evently/module/layout/widget/category.dart';
import 'package:evently/module/layout/widget/event_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AddEventScreen extends StatelessWidget {
  const AddEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Consumer<EventProvider>(builder: (context, provider, child) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: const Text(
              "Create event",
              style: TextStyle(color: AppColor.primaryColor),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                        CategoryCard.items[provider.selectedTabIndex].photo ??
                            ""),
                  ),
                  DefaultTabController(
                    initialIndex: provider.selectedTabIndex,
                    length: CategoryCard.items.length,
                    child: TabBar(
                      indicatorPadding: EdgeInsets.all(0),
                      indicatorColor: Colors.transparent,
                      dividerColor: Colors.transparent,
                      labelColor: theme.primaryColor,
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      labelPadding: EdgeInsets.all(4),
                      onTap: provider.changeTapIndex,
                      tabs: List.generate(Category.items.length, (index) {
                        final item = Category.items[index];
                        final isSelected = provider.selectedTabIndex == index;

                        return Tab(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 5),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColor.primaryColor),
                              borderRadius: BorderRadius.circular(16),
                              color: isSelected
                                  ? AppColor.primaryColor
                                  : Colors.transparent,
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  item.photo!,
                                  color: isSelected
                                      ? Colors.white
                                      : theme.primaryColor,
                                  width: 12,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  item.text ?? '',
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : theme.primaryColor,
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
                    ),
                  ),
                  const Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      "Title",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustTextForm(
                    photo: Image.asset(AppAssets.writer),
                    lableText: " Event Title",
                    controller: provider.titleEditingController,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      "Description",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 120,
                    child: CustTextForm(
                      minline: null,
                      maxline: null,
                      lableText: " Event Description",
                      isExpand: true,
                      controller: provider.descEditingController,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        color: AppColor.primaryColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Event Date",
                        style: TextStyle(color: AppColor.primaryColor),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          provider.pickDate(context);
                        },
                        child: Text(
                          provider.selectedDate == null
                              ? "Choose Date"
                              : DateFormat('dd-MM-yyyy')
                                  .format(provider.selectedDate!),
                          style: TextStyle(color: AppColor.primaryColor),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_outlined,
                        color: AppColor.primaryColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Event Time",
                        style: TextStyle(color: AppColor.primaryColor),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          provider.pickTime(context);
                        },
                        child: Text(
                          provider.selectedTime == null
                              ? "Choose Time"
                              : provider.selectedTime!.format(context),
                          style: TextStyle(color: AppColor.primaryColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      "Location",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColor.primaryColor,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: [
                        Image.asset(AppAssets.calender),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Choose Event Location",
                          style: TextStyle(color: AppColor.primaryColor),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColor.primaryColor,
                        )
                      ]),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(500, 60),
                          backgroundColor: theme.primaryColor,
                          padding: EdgeInsets.all(16),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)))),
                      onPressed: () {
                        provider.addEvent(context);
                      },
                      child: const Text(
                        "Add Event",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
