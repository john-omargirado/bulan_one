import 'package:cloud_firestore/cloud_firestore.dart';
import '/../data/models/service_request.dart';

class ServiceRequestRepository {
  final FirebaseFirestore _db;

  ServiceRequestRepository({FirebaseFirestore? firestore})
    : _db = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _db.collection('service_requests');

  Stream<List<ServiceRequest>> watchMyRequests(String uid) {
    return _collection
        .where('uid', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(ServiceRequest.fromFirestore).toList());
  }

  Future<void> submit(ServiceRequest request) async {
    await _collection.add(request.toFirestore());
  }
}
