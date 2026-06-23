class Hotline {
  final String id;
  final String name;
  final String number;
  final String
  category; // "emergency" | "medical" | "fire" | "police" | "utility"

  const Hotline({
    required this.id,
    required this.name,
    required this.number,
    required this.category,
  });

  factory Hotline.fromFirestore(String id, Map<String, dynamic> data) {
    return Hotline(
      id: id,
      name: data['name'] as String,
      number: data['number'] as String,
      category: data['category'] as String,
    );
  }
}
