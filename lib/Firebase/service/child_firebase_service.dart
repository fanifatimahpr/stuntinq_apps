import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stuntinq_apps/Firebase/models/child_firebase_model.dart';

class ChildHistoryFirebaseService {
  static final CollectionReference historyRef =
      FirebaseFirestore.instance.collection('child_history');

  /// INSERT HISTORY 
  static Future<String> insertHistory(ChildHistoryFirebaseModel model) async {
    try {
      DocumentReference docRef = await historyRef.add(model.toMap());
      await docRef.update({'id': docRef.id}); // simpan id dalam dokumen

      return docRef.id;
    } catch (e) {
      print("Error insertHistory: $e");
      rethrow;
    }
  }

  /// GET ALL HISTORY (seperti sqflite getAllHistory)
  static Future<List<ChildHistoryFirebaseModel>> getAllHistory() async {
    try {
      final query = await historyRef
          .orderBy('createdAt', descending: true)
          .get();

      return query.docs
          .map((doc) => ChildHistoryFirebaseModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error getAllHistory: $e");
      return [];
    }
  }
}
