import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/constants/firestore_paths.dart';
import '../models/office.dart';

class OfficeRepository {
  final FirebaseFirestore _db;

  OfficeRepository({FirebaseFirestore? firestore})
    : _db = firestore ?? FirebaseFirestore.instance;

  Stream<List<Office>> watchAll() {
    return _db
        .collection(FirestorePaths.offices)
        .orderBy('name')
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((d) => Office.fromFirestore(d.id, d.data()))
              .toList(),
        );
  }
}
