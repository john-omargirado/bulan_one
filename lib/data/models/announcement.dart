import 'package:cloud_firestore/cloud_firestore.dart';

class Announcement {
  final String id;
  final String title;
  final String body;
  final String? imageUrl;
  final String tag; // "EVENT", "ADVISORY", etc. — matches mockup badges
  final bool pinned;
  final DateTime createdAt;

  const Announcement({
    required this.id,
    required this.title,
    required this.body,
    this.imageUrl,
    required this.tag,
    this.pinned = false,
    required this.createdAt,
  });

  factory Announcement.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return Announcement(
      id: doc.id,
      title: data['title'] as String,
      body: data['body'] as String,
      imageUrl: data['imageUrl'] as String?,
      tag: data['tag'] as String? ?? 'UPDATE',
      pinned: data['pinned'] as bool? ?? false,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
