import 'package:evently/module/auth/widget/cust_text_form.dart';
import 'package:evently/module/layout/manager/layout_provider.dart';
import 'package:evently/module/layout/widget/event_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoveScreen extends StatefulWidget {
   LoveScreen ({super.key});

  @override
  State<LoveScreen> createState() => _LoveScreenState();
}


class _LoveScreenState extends State<LoveScreen> {

  @override
  void initState() {
    Provider.of<LayoutProvider>(context, listen: false).getEventsFavStream();

    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    return Consumer<LayoutProvider>(
      builder: (context, provider, child) {

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text('Love'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CustTextForm(
                  onChanged: (value) {
                    provider.search(value);
                  },
                  lableText: "Search",
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: provider.FavEvents.length,
                  itemBuilder: (context, index) {
                    return EventCard(event: provider.FavEvents[index]);
                  },
                ),
              ),
            ],
          ),
        );
      },

    );
  }
}
