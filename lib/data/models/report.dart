import 'package:cloud_firestore/cloud_firestore.dart';

enum ReportCategory { flooding, road, streetlight, waste, other }

enum ReportStatus { submitted, inProgress, resolved }

extension ReportCategoryX on ReportCategory {
  String get label {
    switch (this) {
      case ReportCategory.flooding:
        return 'Flooding';
      case ReportCategory.road:
        return 'Road damage';
      case ReportCategory.streetlight:
        return 'Broken streetlight';
      case ReportCategory.waste:
        return 'Waste collection';
      case ReportCategory.other:
        return 'Other concern';
    }
  }
}

extension ReportStatusX on ReportStatus {
  String get label {
    switch (this) {
      case ReportStatus.submitted:
        return 'Submitted';
      case ReportStatus.inProgress:
        return 'In progress';
      case ReportStatus.resolved:
        return 'Resolved';
    }
  }
}

/// A citizen-submitted community issue report.
/// This is a plain data class — it knows nothing about Firestore's API
/// beyond how to read from and write to a document map.
class Report {
  final String? id;
  final String deviceId;
  final ReportCategory category;
  final String description;
  final String? photoUrl;
  final double lat;
  final double lng;
  final String barangay;
  final ReportStatus status;
  final DateTime createdAt;

  const Report({
    this.id,
    required this.deviceId,
    required this.category,
    required this.description,
    this.photoUrl,
    required this.lat,
    required this.lng,
    required this.barangay,
    this.status = ReportStatus.submitted,
    required this.createdAt,
  });

  factory Report.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Report(
      id: doc.id,
      deviceId: data['deviceId'] as String,
      category: ReportCategory.values.firstWhere(
        (c) => c.name == data['category'],
        orElse: () => ReportCategory.other,
      ),
      description: data['description'] as String,
      photoUrl: data['photoUrl'] as String?,
      lat: (data['lat'] as num).toDouble(),
      lng: (data['lng'] as num).toDouble(),
      barangay: data['barangay'] as String,
      status: ReportStatus.values.firstWhere(
        (s) => s.name == data['status'],
        orElse: () => ReportStatus.submitted,
      ),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'deviceId': deviceId,
      'category': category.name,
      'description': description,
      'photoUrl': photoUrl,
      'lat': lat,
      'lng': lng,
      'barangay': barangay,
      'status': status.name,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
