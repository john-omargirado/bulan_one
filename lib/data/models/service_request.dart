import 'package:cloud_firestore/cloud_firestore.dart';

enum RequestStatus { submitted, processing, ready, completed }

extension RequestStatusX on RequestStatus {
  String get label {
    switch (this) {
      case RequestStatus.submitted:
        return 'Submitted';
      case RequestStatus.processing:
        return 'Processing';
      case RequestStatus.ready:
        return 'Ready for pickup';
      case RequestStatus.completed:
        return 'Completed';
    }
  }
}

/// A citizen's request for a specific LGU service (clearance, permit, etc).
/// Separate from Report — this is a service application, not an issue flag.
class ServiceRequest {
  final String? id;
  final String uid;
  final String serviceId;
  final String serviceName;
  final String notes;
  final RequestStatus status;
  final DateTime createdAt;

  const ServiceRequest({
    this.id,
    required this.uid,
    required this.serviceId,
    required this.serviceName,
    required this.notes,
    this.status = RequestStatus.submitted,
    required this.createdAt,
  });

  factory ServiceRequest.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return ServiceRequest(
      id: doc.id,
      uid: data['uid'] as String,
      serviceId: data['serviceId'] as String,
      serviceName: data['serviceName'] as String,
      notes: data['notes'] as String? ?? '',
      status: RequestStatus.values.firstWhere(
        (s) => s.name == data['status'],
        orElse: () => RequestStatus.submitted,
      ),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'serviceId': serviceId,
      'serviceName': serviceName,
      'notes': notes,
      'status': status.name,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
