import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/firebase_manger/event_model/event_model.dart';
import 'package:evently/firebase_manger/firebase_database.dart';
import 'package:evently/module/layout/widget/category.dart';
import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  int selectedTabIndex = 0;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController descEditingController = TextEditingController();
  List<EventModel> events = [];

  void changeTapIndex(int value) {
    selectedTabIndex = value;
    notifyListeners();
  }

  void pickDate(BuildContext context) {
    showDatePicker(
      context: context,
      currentDate: selectedDate,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    ).then((value) {
      if (value != null) {
        selectedDate = value;
        notifyListeners();
      }
    });
  }

  void pickTime(BuildContext context) {
    showTimePicker(initialTime: TimeOfDay.now(), context: context)
        .then((value) {
      if (value != null) {
        selectedTime = value;
        notifyListeners();
      }
    });
  }

  Future<void> addEvent(BuildContext context) async {
    if (titleEditingController.text.isEmpty ||
        descEditingController.text.isEmpty ||
        selectedDate == null ||
        selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter all data")),
      );
      return;
    }

    EventModel data = EventModel(
      title: titleEditingController.text,
      desc: descEditingController.text,
      data: selectedDate!.toIso8601String(),
      time: selectedTime!.format(context),
      categoryId: CategoryCard.items[selectedTabIndex].id,
      categoryImage: CategoryCard.items[selectedTabIndex].photo,
      categoryName: CategoryCard.items[selectedTabIndex].text,
    );

    await FirebaseDatabase.addEvent(data);


    titleEditingController.clear();
    descEditingController.clear();
    selectedDate = null;
    selectedTime = null;
    notifyListeners();

    Navigator.pop(context);
  }


  Future<void> deleteEvent(BuildContext context, EventModel event) async {
    if (event.id != null) {
      await FirebaseFirestore.instance
          .collection('event')
          .doc(event.id)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Event deleted successfully')),
      );
      Navigator.pop(context);
    }
  }

  // دالة التحديث
  Future<void> updateEvent(BuildContext context, EventModel event) async {
    try {
      // تحديث الحدث باستخدام FirebaseDatabase
      EventModel updatedEvent = EventModel(
        id: event.id,
        title: titleEditingController.text,
        desc: descEditingController.text,
        data: selectedDate?.toIso8601String() ?? event.data,
        time: selectedTime?.format(context) ?? event.time,
        categoryId: CategoryCard.items[selectedTabIndex].id,
        categoryImage: CategoryCard.items[selectedTabIndex].photo,
        categoryName: CategoryCard.items[selectedTabIndex].text,
      );

      await FirebaseDatabase.updateEvent(updatedEvent);  // استدعاء دالة التحديث من FirebaseDatabase
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Event updated successfully!")),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating event: $e")),
      );
    }
  }
}
