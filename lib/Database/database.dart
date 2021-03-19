/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class UserServices {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String ref = "My Sources";

  createSourceIDList(Map value) {
    _database.reference().child("$ref").push().set(value).asStream();
  }

  readSourceIDList(Map value) {
    _database.reference().once().then((DataSnapshot dataSnapshot) {
      print(dataSnapshot.value);
    });
  }

  Future getDataList() async {
    List data = [];
    try {
      await FirebaseFirestore.instance
          .collection("Sources")
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          data.add(element.data());
        });
      });
      return data;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
*/