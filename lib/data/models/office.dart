class Office {
  final String id;
  final String name;
  final String barangay;
  final double lat;
  final double lng;
  final String contactNumber;
  final String hours;

  const Office({
    required this.id,
    required this.name,
    required this.barangay,
    required this.lat,
    required this.lng,
    required this.contactNumber,
    required this.hours,
  });

  factory Office.fromFirestore(String id, Map<String, dynamic> data) {
    return Office(
      id: id,
      name: data['name'] as String,
      barangay: data['barangay'] as String,
      lat: (data['lat'] as num).toDouble(),
      lng: (data['lng'] as num).toDouble(),
      contactNumber: data['contactNumber'] as String,
      hours: data['hours'] as String,
    );
  }
}
