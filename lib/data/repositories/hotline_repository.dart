import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/constants/firestore_paths.dart';
import '../models/hotline.dart';

class HotlineRepository {
  final FirebaseFirestore _db;

  HotlineRepository({FirebaseFirestore? firestore})
    : _db = firestore ?? FirebaseFirestore.instance;

  Stream<List<Hotline>> watchAll() {
    return _db
        .collection(FirestorePaths.hotlines)
        .orderBy('category')
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((d) => Hotline.fromFirestore(d.id, d.data()))
              .toList(),
        );
  }
}
