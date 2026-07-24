import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stay_awhile_mobile/feature/profile/data/models/profile_model.dart';

class ProfileRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  ProfileRemoteDataSource({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  String get _uid {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');
    return user.uid;
  }

  Future<ProfileModel> fetchProfile() async {
    final doc = await _firestore.collection('users').doc(_uid).get();
    if (!doc.exists) throw Exception('Profile not found');
    return ProfileModel.fromFirestore(doc);
  }

  Future<List<DroppedMessageModel>> fetchDroppedMessages() async {
    final snapshot = await _firestore
        .collection('messages')
        .where('authorId', isEqualTo: _uid)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => DroppedMessageModel.fromFirestore(doc))
        .toList();
  }

  Future<void> deleteMessage(String messageId) async {
    await _firestore.collection('messages').doc(messageId).delete();
    await _firestore.collection('users').doc(_uid).update({
      'messagesDropped': FieldValue.increment(-1),
    });
  }
}
