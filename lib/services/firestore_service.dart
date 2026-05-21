import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> toggleFavorite(String lessonId, bool isFavorite) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final docRef = _db.collection('users')
        .doc(userId).collection('favorites').doc(lessonId);

    if (isFavorite) {
      await docRef.set(
          {
            'lessonId': lessonId,
            'timestamp': FieldValue.serverTimestamp()
          }
      );
    } else {
      await docRef.delete();
    }
  }
}