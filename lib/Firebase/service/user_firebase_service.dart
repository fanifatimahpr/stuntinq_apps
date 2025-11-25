import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stuntinq_apps/Firebase/models/user_firebase_model.dart';

class FirebaseService {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// REGISTER USER
  static Future<UserFirebaseModel> registerUser({
    required String email,
    required String fullname,
    required String phonenumber,
    required String password,
  }) async {
    final cred = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = cred.user!;

    final model = UserFirebaseModel(
      uid: user.uid,
      fullname: fullname,
      email: email,
      phonenumber: phonenumber,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );

    await firestore.collection('users').doc(user.uid).set(model.toMap());
    return model;
  }

  /// LOGIN USER
  static Future<UserFirebaseModel?> loginUser({
    required String email,
    required String password,
  }) async {
    final cred = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = cred.user;
    if (user == null) return null;

    return await getUserByUid(user.uid);
  }

  /// GET USER BY UID (PENTING)
  static Future<UserFirebaseModel?> getUserByUid(String uid) async {
    final snap = await firestore.collection('users').doc(uid).get();

    if (!snap.exists || snap.data() == null) return null;

    return UserFirebaseModel.fromMap({
      "uid": uid,
      ...snap.data()!,
    });
  }

  /// GET USER CURRENT LOGIN
  static Future<UserFirebaseModel?> getCurrentUser() async {
    final current = auth.currentUser;
    if (current == null) return null;

    return await getUserByUid(current.uid);
  }

  /// LOGOUT
  static Future<void> logout() async {
    await auth.signOut();
  }
  
  // UPDATE USER
  static Future<void> updateUser({
  required String uid,
  required String fullname,
  required String email,
  required String phonenumber,
}) async {
  await firestore.collection('users').doc(uid).update({
    'fullname': fullname,
    'email': email,
    'phonenumber': phonenumber,
    'updatedAt': DateTime.now().toIso8601String(),
  });
}

// DELETE USER (Firestore + Firebase Auth)
  static Future<void> deleteUser(String uid) async {
    try {
      // Hapus dari Firestore
      await firestore.collection('users').doc(uid).delete();

      // Hapus dari Firebase Auth
      User? user = auth.currentUser;
      if (user != null && user.uid == uid) {
        await user.delete();
      } else {
        // Jika user saat ini bukan yang dihapus, perlu login ulang
        throw "User not logged in or mismatch UID";
      }
    } catch (e) {
      rethrow; // lempar error supaya bisa ditangani di UI
    }
  }

}
