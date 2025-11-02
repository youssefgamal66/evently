import 'package:evently/core/const/app_assets.dart';
import 'package:evently/firebase_manger/event_model/event_model.dart';
import 'package:evently/module/layout/manager/layout_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.event});

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LayoutProvider>(context);
    var theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.all(12),
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(event.categoryImage),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    DateFormat("d").format(DateTime.parse(event.data)), // اليوم
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
                    ),
                  ),
                  Text(
                    DateFormat("EEE").format(DateTime.parse(event.data)),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: theme.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    event.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                InkWell(
                  onTap: () {
                    provider.addFav(event);
                  },
                  child: Icon(
                    event.isFav ? Icons.favorite : Icons.favorite_border,
                    color: theme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
