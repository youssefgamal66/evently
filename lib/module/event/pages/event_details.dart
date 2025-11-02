import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/app_theme/app_color.dart';
import 'package:evently/core/const/app_assets.dart';
import 'package:evently/core/routes/app_route_name.dart';
import 'package:evently/firebase_manger/event_model/event_model.dart';
import 'package:evently/module/event/manger/event_provider.dart';
import 'package:evently/module/layout/manager/layout_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Eventdetails extends StatefulWidget {
  Eventdetails({super.key, this.event});

  final EventModel? event;

  @override
  State<Eventdetails> createState() => _EventdetailsState();
}

class _EventdetailsState extends State<Eventdetails> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LayoutProvider>(context, listen: false).getEventsStream("All");
    });
  }


  @override
  Widget build(BuildContext context) {
    final DateTime dateTime = DateTime.tryParse(widget.event?.data ?? "") ?? DateTime.now();

    var theme = Theme.of(context);

    return Consumer<LayoutProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          foregroundColor: AppColor.primaryColor,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    RouteName.eventEdit,
                    arguments: widget.event,
                  );

                },
                icon: const Icon(
                  Icons.edit,
                  color: AppColor.primaryColor,
                  size: 30,
                )),
            IconButton(
              onPressed: () async {
                if (widget.event != null) {
                  await Provider.of<EventProvider>(context, listen: false)
                      .deleteEvent(context, widget.event!);
                }
              },

              icon: const Icon(
                Icons.delete_rounded,
                color: Colors.red,
                size: 30,
              ),
            )

          ],
          backgroundColor: Colors.transparent,
          title: const Text(
            "Event Details",
            style: TextStyle(color: AppColor.primaryColor, fontSize: 24),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: Image.asset(widget.event?.categoryImage ?? "")),
                const SizedBox(height: 10),
                Text(
                  widget.event?.title ?? "",
                  style: const TextStyle(
                    color: AppColor.primaryColor,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColor.primaryColor,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset(AppAssets.calender),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat("dd MMMM yyyy").format(dateTime),
                              style: const TextStyle(color: AppColor.primaryColor),
                            ),
                            Text(
                              DateFormat("hh:mm a").format(dateTime),
                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColor.primaryColor,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset(AppAssets.calender),
                        const SizedBox(width: 10),
                        const Text(
                          "Cairo , Egypt ",
                          style: TextStyle(color: AppColor.primaryColor),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColor.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      AppAssets.map,
                      fit: BoxFit.cover,
                    )),
                const SizedBox(height: 10),
                const Text(
                  "Description",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(widget.event?.desc ?? "")
              ],
            ),
          ),
        ),
      );
    });
  }
}
