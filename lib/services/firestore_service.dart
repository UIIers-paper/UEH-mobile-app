import 'package:ueh_mobile_app/utils/exports.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getData(String collection) async {
    try {
      QuerySnapshot snapshot = await _db.collection(collection).get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print("Error getting data: $e");
      return [];
    }
  }

  Future<void> addData(String collection, Map<String, dynamic> data) async {
    try {
      await _db.collection(collection).add(data);
      print("Data added successfully");
    } catch (e) {
      print("Error adding data: $e");
    }
  }

  Future<void> updateData(String collection, String docId, Map<String, dynamic> data) async {
    try {
      await _db.collection(collection).doc(docId).update(data);
      print("Data updated successfully");
    } catch (e) {
      print("Error updating data: $e");
    }
  }

  Future<void> deleteData(String collection, String docId) async {
    try {
      await _db.collection(collection).doc(docId).delete();
      print("Data deleted successfully");
    } catch (e) {
      print("Error deleting data: $e");
    }
  }
}
