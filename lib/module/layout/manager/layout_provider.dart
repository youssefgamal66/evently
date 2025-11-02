import 'package:evently/firebase_manger/event_model/event_model.dart';
import 'package:evently/firebase_manger/firebase_database.dart';
import 'package:evently/module/layout/pages/screens/home_screen.dart';
import 'package:evently/module/layout/pages/screens/love_screen.dart';
import 'package:evently/module/layout/pages/screens/map_screen.dart';
import 'package:evently/module/layout/pages/screens/profile_screen.dart';
import 'package:evently/module/layout/widget/category.dart';
import 'package:flutter/material.dart';

class LayoutProvider extends ChangeNotifier {
  int selectedIndex = 0;
  int selectedTapIndex=0;
  List<EventModel>events=[];
  List<EventModel>FavEvents=[];

  List<Widget> screens = [
    HomeScreen(),
    MapScreen(),
    LoveScreen(),
    ProfileScreen()
  ];
  void ChangeNavIndex(int value) {
    selectedIndex = value;
    notifyListeners();
  }

  void ChangeTapIndex(int value) {
    selectedTapIndex = value;
    getEventsStream(value==0?"All":CategoryCard.items[value-1].id);
    notifyListeners();
  }
  Future<void>getEvents()async{
    var date=await FirebaseDatabase.getEvent();
    events.clear();
    for(var e in date){
      events.add(e.data());
      notifyListeners();

    }
  }
  void getEventsStream(String cat) {
    events.clear();

    FirebaseDatabase.getEventStream(cat).listen((event) {
      events.clear();
      for (var e in event.docs) {
        events.add(e.data());
      }

      notifyListeners();
    });
  }
  void getEventsFavStream() {
    FavEvents.clear();

    FirebaseDatabase.getEventFavStream().listen((event) {
      FavEvents.clear();
      for (var e in event.docs) {
        FavEvents.add(e.data());
        notifyListeners();
      }

    });
  }
void search(String q){
    if (q.isEmpty){
      getEventsFavStream();
    }else
      {
        FavEvents=FavEvents.where((element){
          return element.title.toLowerCase().contains(q.toLowerCase());
        }).toList();
        notifyListeners();
      }
    
}


  Future<void>addFav(EventModel data){
    return FirebaseDatabase.addFav(data);

  }



}
