import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/constants/firestore_paths.dart';
import '../models/announcement.dart';

class AnnouncementRepository {
  final FirebaseFirestore _db;

  AnnouncementRepository({FirebaseFirestore? firestore})
    : _db = firestore ?? FirebaseFirestore.instance;

  /// Pinned announcements first, then newest first — matches the
  /// "Latest Announcements" section ordering in the mockup.
  Stream<List<Announcement>> watchAll({int limit = 20}) {
    return _db
        .collection(FirestorePaths.announcements)
        .orderBy('pinned', descending: true)
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((snap) => snap.docs.map(Announcement.fromFirestore).toList());
  }
}
