import 'package:cloud_firestore/cloud_firestore.dart';

class ArticleFirebaseModel {
  final String id;
  final String title;
  final String category;
  final String content;
  final int baseLikes;

  ArticleFirebaseModel({
    required this.id,
    required this.title,
    required this.category,
    required this.content,
    required this.baseLikes,
  });

  factory ArticleFirebaseModel.fromMap(String id, Map<String, dynamic> map) {
    return ArticleFirebaseModel(
      id: id,
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      content: map['content'] ?? '',
      baseLikes: map['baseLikes'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'category': category,
      'content': content,
      'baseLikes': baseLikes,
    };
  }
}

// BOOKMARK
class BookmarkModel {
  final String userId;
  final DateTime savedAt;

  BookmarkModel({
    required this.userId,
    required this.savedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "savedAt": savedAt,
    };
  }

  factory BookmarkModel.fromMap(Map<String, dynamic> map) {
    return BookmarkModel(
      userId: map["userId"],
      savedAt: (map["savedAt"] as Timestamp).toDate(),
    );
  }
}


// LIKE MODEL
class LikeModel {
  final String userId;
  final DateTime likedAt;

  LikeModel({
    required this.userId,
    required this.likedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "likedAt": likedAt,
    };
  }

  factory LikeModel.fromMap(Map<String, dynamic> map) {
    return LikeModel(
      userId: map["userId"],
      likedAt: (map["likedAt"] as Timestamp).toDate(),
    );
  }
}
