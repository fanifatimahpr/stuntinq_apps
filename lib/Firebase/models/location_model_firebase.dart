import 'package:cloud_firestore/cloud_firestore.dart';

class UserLocation {
  final double latitude;
  final double longitude;
  final String address;
  final DateTime updatedAt;

  UserLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.updatedAt,
  });

  factory UserLocation.fromMap(Map<String, dynamic> map) {
    return UserLocation(
      latitude: map["latitude"],
      longitude: map["longitude"],
      address: map["address"],
      updatedAt: (map["updatedAt"] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "latitude": latitude,
      "longitude": longitude,
      "address": address,
      "updatedAt": updatedAt,
    };
  }
}
