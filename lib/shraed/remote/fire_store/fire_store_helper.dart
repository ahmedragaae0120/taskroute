import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:taskroute/models/courses_model.dart';
import 'package:taskroute/models/user_Model.dart';

class fireStoreHelper {
  static CollectionReference<userModel> getUserCollections() {
    var refernce = FirebaseFirestore.instance.collection("User").withConverter(
      fromFirestore: (snapshot, options) {
        Map<String, dynamic>? data = snapshot.data();
        return userModel.fromFirestore(data ?? {});
      },
      toFirestore: (userModel, options) {
        return userModel.toFirestore();
      },
    );
    return refernce;
  }

  static Future<void> addUser(
      {required String userId,
      required String email,
      required String name}) async {
    var document = getUserCollections().doc(userId);
    await document.set(userModel(id: userId, name: name, email: email));
  }

  static Future<userModel?> getUser(String userId) async {
    var userDoc = getUserCollections().doc(userId);
    var snapShot = await userDoc.get();
    userModel? user = snapShot.data();
    return user;
  }

  static CollectionReference<courseModel> getCoursesCollections() {
    var refernce =
        FirebaseFirestore.instance.collection("Courses").withConverter(
              fromFirestore: (snapshot, options) {
                Map<String, dynamic>? data = snapshot.data();
                return courseModel.FromFirestore(data ?? {});
              },
              toFirestore: (courseModel, options) => courseModel.toFirestore(),
            );
    return refernce;
  }

  static Future<void> addCourse({required courseModel course}) async {
    var doucment = getCoursesCollections().doc(course.courseId);
    course.courseId = doucment.id;
    await doucment.set(course);
  }

  static Future<List<courseModel>> getAllCourse() async {
    var courseQuery = await getCoursesCollections().get();
    List<courseModel> coursesList =
        courseQuery.docs.map((Snapshot) => Snapshot.data()).toList();
    return coursesList;
  }

  static Future<List<courseModel>> getBestSellingCourse() async {
    var courseQuery = await getCoursesCollections()
        .orderBy("studentNum", descending: true)
        .get();
    List<courseModel> coursesList =
        courseQuery.docs.map((Snapshot) => Snapshot.data()).toList();
    return coursesList;
  }
}
