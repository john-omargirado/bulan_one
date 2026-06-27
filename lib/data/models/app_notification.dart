import 'package:cloud_firestore/cloud_firestore.dart';

class AppNotification {
  final String id;
  final String title;
  final String body;
  final DateTime createdAt;

  const AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
  });

  factory AppNotification.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return AppNotification(
      id: doc.id,
      title: data['title'] as String,
      body: data['body'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
