import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/firebase_manger/event_model/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDatabase {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static CollectionReference<EventModel> getRef() {
    return firestore.collection("event").withConverter<EventModel>(
        fromFirestore: (snapshot, option) {
          return EventModel.fromJson(snapshot.data()!);
        },
        toFirestore: (value, option) {
          return value.toJson();
        }
    );
  }

  static Future<void> addEvent(EventModel data) {
    var ref = getRef();
    var doc = ref.doc();
    data.id = doc.id;
    return doc.set(data);
  }

  static Future<void> addFav(EventModel data) {
    var ref = getRef();
    var doc = ref.doc(data.id);
    data.isFav = !data.isFav;
    return doc.set(data);
  }

  static Future<List<QueryDocumentSnapshot<EventModel>>> getEvent() async {
    var ref = getRef().where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid);
    var date = await ref.get();
    return date.docs;
  }

  static Stream<QuerySnapshot<EventModel>> getEventStream(String cat) {
    var ref = cat == "All"
        ? getRef().where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        : getRef().where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid).where("categoryId", isEqualTo: cat);
    return ref.snapshots();
  }

  static Stream<QuerySnapshot<EventModel>> getEventFavStream() {
    var ref = getRef()
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("isFav", isEqualTo: true);
    return ref.snapshots();
  }

  Future<void> deleteCard(String collectionName, String docId) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(docId)
        .delete();
  }

  static Future<void> updateEvent(EventModel event) async {
    try {
      var ref = getRef().doc(event.id);

      await ref.update(event.toJson());
    } catch (e) {
      print("Error updating event: $e");
      throw e;
    }
  }
}
