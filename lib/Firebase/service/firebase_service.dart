import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stuntinq_apps/Firebase/models/child_birth_firebase_model.dart';
import 'package:stuntinq_apps/Firebase/models/child_firebase_model.dart';
import 'package:stuntinq_apps/Firebase/models/location_model_firebase.dart';
import 'package:stuntinq_apps/Firebase/models/nutrition_firebase.dart';
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

/// DATA PAGE

 static final CollectionReference historyRef =
      FirebaseFirestore.instance.collection('child_history');

  // INSERT HISTORY CHILD
 static Future<String> insertHistory(ChildHistoryFirebaseModel model) async {
  try {
    DocumentReference doc = await historyRef.add({
      ...model.toMap(),
      "uid": auth.currentUser!.uid, // WAJIB!
    });

    await doc.update({"id": doc.id});
    return doc.id;
  } catch (e) {
    print("Error insertHistory: $e");
    rethrow;
  }
}


// GET HISTORY CHILD
static Future<List<ChildHistoryFirebaseModel>> getAllHistory(String uid) async {
  try {
    final query = await historyRef
        .where("uid", isEqualTo: uid)
        // .orderBy("createdAt", descending: true)
        .get();

    return query.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return ChildHistoryFirebaseModel.fromMap(data);
    }).toList();
  } catch (e) {
    print("Error getAllHistory: $e");
    return [];
  }
}

// SAVE HISTORY (langsung dari form input)
static Future<String> saveChildHistory({
  required String name,
  required int age,
  required double weight,
  required double height,
  required double head,
  required double imt,
}) async {
  try {
    final uid = auth.currentUser!.uid;

    final model = ChildHistoryFirebaseModel(
      id: null,
      uid: uid,
      name: name,
      age: age,
      weight: weight,
      height: height,
      imt: imt,
      head: head,
      createdAt: DateTime.now(),
    );

    return await insertHistory(model);
  } catch (e) {
    print("Error saveChildHistory: $e");
    rethrow;
  }
}

static final CollectionReference nutritionRef =
    FirebaseFirestore.instance.collection('nutrition');
// INSERT NUTRITION
static Future<String> insertNutrition(NutritionSourceFirebaseModel model) async {
  try {
    // Buat doc kosong untuk dapat ID terlebih dulu
    DocumentReference doc = nutritionRef.doc();

    // Simpan data sekaligus dengan ID
    await doc.set({
      "id": doc.id,
      "uid": auth.currentUser!.uid,
      "name": model.name,
      "portion": model.portion,
      "dateAdded": Timestamp.fromDate(model.dateAdded),
    });

    return doc.id;
  } catch (e) {
    print("Insert Nutrition Error: $e");
    rethrow;
  }
}

// GET ALL NUTRITION
static Future<List<NutritionSourceFirebaseModel>> getAllNutrition() async {
  try {
    final uid = auth.currentUser!.uid;

    final query = await nutritionRef
        .where("uid", isEqualTo: uid)
        // .orderBy("dateAdded", descending: true)
        .get();
    print(query.docs);
    return query.docs
        .map((doc) => NutritionSourceFirebaseModel.fromMap(
            doc.data() as Map<String, dynamic>))
        .toList();
  } catch (e) {
    print("Get Nutrition Error: $e");
    return [];
  }
}


// UPDATE NUTRITION
static Future<void> updateNutrition(NutritionSourceFirebaseModel model) async {
  try {
    await nutritionRef.doc(model.id).update(model.toMap());
  } catch (e) {
    print("Update Nutrition Error: $e");
    rethrow;
  }
}

// DELETE NUTRITION
static Future<void> deleteNutrition(String id) async {
  try {
    await nutritionRef.doc(id).delete();
  } catch (e) {
    print("Delete Nutrition Error: $e");
    rethrow;
  }
}

/// IMUNISASI PAGE
  static CollectionReference get birthRef =>
      firestore.collection("child_birth");

  // SAVE BIRTHDAY
  static Future<void> saveBirthDate(DateTime birthDate) async {
    final uid = auth.currentUser!.uid;

    final model = ChildBirthModel(uid: uid, birthDate: birthDate);

    await birthRef.doc(uid).set(model.toMap());
  }

  // GET BIRTHDAY
  static Future<DateTime?> getBirthDate() async {
    final uid = auth.currentUser!.uid;
    final doc = await birthRef.doc(uid).get();

    if (!doc.exists) return null;

    final data = doc.data() as Map<String, dynamic>;
    return (data["birthDate"] as Timestamp).toDate();
  }

  /// ARTIKEL PAGE 
  // Toggle Bookmark
  static Future<void> toggleBookmark(String articleId) async {
    final uid = auth.currentUser!.uid;

    final ref = firestore
        .collection("articles")
        .doc(articleId)
        .collection("bookmarks")
        .doc(uid);

    final snap = await ref.get();

    if (snap.exists) {
      await ref.delete();
    } else {
      await ref.set({
        "userId": uid,
        "savedAt": Timestamp.now(),
      });
    }
  }

  // Toggle Like
  static Future<void> toggleLike(String articleId) async {
    final uid = auth.currentUser!.uid;

    final ref = firestore
        .collection("articles")
        .doc(articleId)
        .collection("likes")
        .doc(uid);

    final snap = await ref.get();

    if (snap.exists) {
      await ref.delete();
    } else {
      await ref.set({
        "userId": uid,
        "likedAt": Timestamp.now(),
      });
    }
  }

  // Check Bookmark
  static Future<bool> isBookmarked(String articleId) async {
    final uid = auth.currentUser!.uid;

    final doc = await firestore
        .collection("articles")
        .doc(articleId)
        .collection("bookmarks")
        .doc(uid)
        .get();

    return doc.exists;
  }

  // Check Like
  static Future<bool> isLiked(String articleId) async {
    final uid = auth.currentUser!.uid;

    final doc = await firestore
        .collection("articles")
        .doc(articleId)
        .collection("likes")
        .doc(uid)
        .get();

    return doc.exists;
  }

  // Like Count (stream real-time)
  static Stream<int> likeCount(String articleId) {
    return firestore
        .collection("articles")
        .doc(articleId)
        .collection("likes")
        .snapshots()
        .map((snap) => snap.size);
  }

/// PETA PAGE
  // SAVE or UPDATE current user location
  static Future<void> saveUserLocation({
    required double latitude,
    required double longitude,
    required String address,
  }) async {
    final userId = auth.currentUser!.uid;
    
    await firestore.collection("locations").doc(userId).set({
      "latitude": latitude,
      "longitude": longitude,
      "address": address,
      "updatedAt": Timestamp.now(),
    }, SetOptions(merge: true));

    // Optional: save history
    await firestore
        .collection("location_history")
        .doc(userId)
        .collection("records")
        .add({
      "latitude": latitude,
      "longitude": longitude,
      "address": address,
      "timestamp": Timestamp.now(),
    });
  }

  // GET location once
  static Future<UserLocation?> getUserLocation() async {
    final userId = auth.currentUser!.uid;
    final doc = await firestore.collection("locations").doc(userId).get();

    if (!doc.exists) return null;
    return UserLocation.fromMap(doc.data()!);
  }

  // STREAM real-time location
  static Stream<UserLocation?> streamUserLocation() {
    final userId = auth.currentUser!.uid;

    return firestore.collection("locations").doc(userId).snapshots().map((snap) {
      if (!snap.exists) return null;
      return UserLocation.fromMap(snap.data()!);
    });
  }

  /// DELETE location
  static Future<void> deleteLocation() async {
    final userId = auth.currentUser!.uid;
    await firestore.collection("locations").doc(userId).delete();
  }

}
