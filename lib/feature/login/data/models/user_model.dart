import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String displayName;
  final String email;
  final String? photoUrl;
  final String? bio;
  final DateTime? joinDate;
  final int messagesDropped;
  final int messagesFound;

  UserModel({
    required this.uid,
    required this.displayName,
    required this.email,
    this.photoUrl,
    this.bio,
    this.joinDate,
    this.messagesDropped = 0,
    this.messagesFound = 0,
  });

  factory UserModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return UserModel(
      uid: doc.id,
      displayName: data['displayName'] as String? ?? '',
      email: data['email'] as String? ?? '',
      photoUrl: data['photoUrl'] as String?,
      bio: data['bio'] as String?,
      joinDate: (data['joinDate'] as Timestamp?)?.toDate(),
      messagesDropped: (data['messagesDropped'] as num?)?.toInt() ?? 0,
      messagesFound: (data['messagesFound'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
      'bio': bio,
      'joinDate': FieldValue.serverTimestamp(),
      'messagesDropped': messagesDropped,
      'messagesFound': messagesFound,
    };
  }
}
