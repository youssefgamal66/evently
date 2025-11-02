import 'package:firebase_auth/firebase_auth.dart';

class EventModel {
  String? id;
  String title;
  String desc;
  String data;
  String time;
  String categoryId;
  String categoryImage;
  String categoryName;
  bool isFav;
   String? userId;

  EventModel(
      {this.id,
      required this.title,
      required this.desc,
      required this.data,
      required this.time,
      required this.categoryId,
      required this.categoryImage,
      required this.categoryName,


      this.isFav=false,
      }

      ){
    userId=FirebaseAuth.instance.currentUser!.uid;

  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "desc": desc,
      "data": data,
      "time": time,
      "isFav":isFav,
      "categoryId": categoryId,
      "categoryImage": categoryImage,
      "categoryName": categoryName,
      "userId":userId
    };
  }

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json["id"],
        title: json["title"],
        desc: json["desc"],
        data: json["data"],
        time: json["time"],
        isFav: json["isFav"]??false,
        categoryId: json["categoryId"],
        categoryImage: json["categoryImage"],
        categoryName: json["categoryName"]);
  }
}
