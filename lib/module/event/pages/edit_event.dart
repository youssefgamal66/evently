import 'package:evently/core/app_theme/app_color.dart';
import 'package:evently/core/const/app_assets.dart';
import 'package:evently/firebase_manger/event_model/event_model.dart';
import 'package:evently/module/auth/widget/cust_text_form.dart';
import 'package:evently/module/event/manger/event_provider.dart';
import 'package:evently/module/layout/manager/layout_provider.dart';
import 'package:evently/module/layout/widget/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class EditEvent extends StatefulWidget {
   EditEvent({super.key,this.event});
 EventModel? event;
  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LayoutProvider>(context, listen: false).getEventsStream("All");
    });
  }

  @override
  Widget build(BuildContext context) {
    final event = ModalRoute.of(context)?.settings.arguments as EventModel;
    final DateTime dateTime = DateTime.tryParse(event.data ?? "") ?? DateTime.now();

    var theme = Theme.of(context);
    return Consumer<EventProvider>(builder: (context, provider, child) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: const Text(
              "Edit event",
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
                      CategoryCard.items[provider.selectedTabIndex].photo ?? "",
                    ),
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
                            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColor.primaryColor),
                              borderRadius: BorderRadius.circular(16),
                              color: isSelected ? AppColor.primaryColor : Colors.transparent,
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  item.photo,
                                  color: isSelected ? Colors.white : theme.primaryColor,
                                  width: 12,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  item.text ?? '',
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : theme.primaryColor,
                                    fontSize: 10,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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
                  const SizedBox(height: 5),
                  CustTextForm(
                    photo: Image.asset(AppAssets.writer),
                    hinText: event.title,
                  ),
                  const SizedBox(height: 5),
                  const Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      "Description",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 120,
                    child: CustTextForm(
                      minline: null,
                      maxline: null,
                      hinText: event.desc,
                      isExpand: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Icon(Icons.calendar_month, color: AppColor.primaryColor),
                      const SizedBox(width: 10),
                      const Text("Event Date", style: TextStyle(color: AppColor.primaryColor)),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          provider.pickDate(context);
                        },
                        child: Text(
                          DateFormat("dd MMMM yyyy").format(dateTime),
                          style: const TextStyle(color: AppColor.primaryColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.access_time_outlined, color: AppColor.primaryColor),
                      const SizedBox(width: 10),
                      const Text("Event Time", style: TextStyle(color: AppColor.primaryColor)),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          provider.pickTime(context);
                        },
                        child: Text(
                          DateFormat("hh:mm a").format(dateTime),
                          style: const TextStyle(color: AppColor.primaryColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      "Location",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColor.primaryColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: [
                        Image.asset(AppAssets.calender),
                        const SizedBox(width: 10),
                        const Text("Choose Event Location", style: TextStyle(color: AppColor.primaryColor)),
                        const Spacer(),
                        const Icon(Icons.arrow_forward_ios, color: AppColor.primaryColor),
                      ]),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(500, 60),
                      backgroundColor: theme.primaryColor,
                      padding: const EdgeInsets.all(16),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                    onPressed: () {



                     provider.updateEvent(context, event);
                    },

                    child: const Text(
                      "Update Event",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
