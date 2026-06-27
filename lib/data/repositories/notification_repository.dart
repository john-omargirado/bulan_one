import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/app_notification.dart';

class NotificationRepository {
  final FirebaseFirestore _db;

  NotificationRepository({FirebaseFirestore? firestore})
    : _db = firestore ?? FirebaseFirestore.instance;

  Stream<List<AppNotification>> watchAll({int limit = 20}) {
    return _db
        .collection('notifications')
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((snap) => snap.docs.map(AppNotification.fromFirestore).toList());
  }
}
