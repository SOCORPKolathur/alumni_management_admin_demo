import 'dart:html';
import 'package:alumni_management_admin/Models/Colleage_activity.dart';
import 'package:alumni_management_admin/Models/Response_Model.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';




final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference activtyCollection = firestore.collection('ColleageActivities');
final FirebaseStorage fs = FirebaseStorage.instance;

class ActivityFireCrud {
  static Stream<List<ColleageActivityModel>> fetchActivityPost() =>
      activtyCollection
          .orderBy("timestamp", descending: false)
          .snapshots().map((snapshot) => snapshot.docs
          .map((doc) => ColleageActivityModel.fromJson(doc.data() as Map<String,dynamic>))
          .toList());

  static Stream<List<ColleageActivityModel>> fetchActivityWithFilter(DateTime start, DateTime end) =>
      activtyCollection
          .orderBy("timestamp", descending: false)
          .snapshots()
          .map((snapshot) => snapshot.docs
          .where((element) => element['timestamp'] < end.add(const Duration(days: 1)).millisecondsSinceEpoch && element['timestamp'] >= start.millisecondsSinceEpoch)
          .map((doc) => ColleageActivityModel.fromJson(doc.data() as Map<String,dynamic>))
          .toList());

  static Future<Response> addEvent({
    required String time,
    required String title,
    required String location,
    required File? image,
    required String description,
    required String date,
    required String activityType,
    required String activityDep,
    required String activityYear,
  }) async {
    String downloadUrl = '';
    if(image != null){
      downloadUrl = await uploadImageToStorage(image);
    }
    Response response = Response();
    DocumentReference documentReferencer = activtyCollection.doc();
    DateTime tempDate = DateFormat("dd-MM-yyyy").parse(date);
    ColleageActivityModel event = ColleageActivityModel(
      time: time,
      title: title,
      activityType: activityType,
      activityDep: activityDep,
      activityYear: activityYear,
      timestamp: tempDate.millisecondsSinceEpoch,
      location: location,
      imgUrl: image != null ? downloadUrl : '',
      id: "",
      description: description,
      date: date,
      views: [],
      registeredUsers: [],
    );
    event.id = documentReferencer.id;
    var json = event.toJson();
    var result = await documentReferencer.set(json).whenComplete(() {
      response.code = 200;
      response.message = "Successfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });
    return response;
  }

  static Future<String> uploadImageToStorage(file) async {
    var snapshot = await fs
        .ref()
        .child('dailyupdates')
        .child("${file.name}")
        .putBlob(file);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  static Future<Response> updateRecord(
      ColleageActivityModel event, File? image, String imgUrl) async {
    Response res = Response();
    if (image != null) {
      String downloadUrl = await uploadImageToStorage(image);
      event.imgUrl = downloadUrl;
    } else {
      event.imgUrl = imgUrl;
    }
    DocumentReference documentReferencer = activtyCollection.doc(event.id);
    var result =
    await documentReferencer.update(event.toJson()).whenComplete(() {
      res.code = 200;
      res.message = "Successfully Updated from database";
    }).catchError((e) {
      res.code = 500;
      res.message = e;
    });
    return res;
  }

  static Future<Response> deleteRecord({required String id}) async {
    Response res = Response();
    DocumentReference documentReferencer = activtyCollection.doc(id);
    var result = await documentReferencer.delete().whenComplete(() {
      res.code = 200;
      res.message = "Successfully Deleted from database";
    }).catchError((e) {
      res.code = 500;
      res.message = e;
    });
    return res;
  }
}
