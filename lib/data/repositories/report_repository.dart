import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import '../../core/constants/firestore_paths.dart';
import '../models/report.dart';

/// Owns all reads/writes to the reports collection and the
/// associated photo uploads in Storage. Nothing outside this file
/// should know Firestore exists.
class ReportRepository {
  final FirebaseFirestore _db;
  final FirebaseStorage _storage;

  ReportRepository({FirebaseFirestore? firestore, FirebaseStorage? storage})
    : _db = firestore ?? FirebaseFirestore.instance,
      _storage = storage ?? FirebaseStorage.instance;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _db.collection(FirestorePaths.reports);

  /// Live stream of reports submitted by this device, newest first.
  Stream<List<Report>> watchMyReports(String deviceId) {
    return _collection
        .where('deviceId', isEqualTo: deviceId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(Report.fromFirestore).toList());
  }

  /// Uploads a photo and returns its public download URL.
  /// Call this before submit() if the report includes a photo.
  Future<String> uploadPhoto(File file, String deviceId) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final ref = _storage.ref('report_photos/$deviceId/$fileName');
    final task = await ref.putFile(file);
    return task.ref.getDownloadURL();
  }

  Future<void> submit(Report report) async {
    await _collection.add(report.toFirestore());
  }
}
