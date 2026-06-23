/// Static destination data for the Explore tab.
/// Not Firestore-backed — promote to a real collection later if
/// the LGU wants to manage this content without a code deploy.
class Destination {
  final String name;
  final String category; // "Nature & Adventure", "Beach Destination", etc.
  final String imageSeed; // used to generate a stable placeholder image
  final double rating;

  const Destination({
    required this.name,
    required this.category,
    required this.imageSeed,
    required this.rating,
  });
}

const List<Destination> bulanDestinations = [
  Destination(
    name: 'Bulan Eco Park',
    category: 'Nature & Adventure',
    imageSeed: 'bulan-eco-park',
    rating: 4.6,
  ),
  Destination(
    name: 'Bariis Lake',
    category: 'Nature Escape',
    imageSeed: 'bariis-lake',
    rating: 4.5,
  ),
  Destination(
    name: 'Sabang Beach',
    category: 'Beach Destination',
    imageSeed: 'sabang-beach',
    rating: 4.4,
  ),
  Destination(
    name: 'Bulan Freedom Park',
    category: 'History & Heritage',
    imageSeed: 'freedom-park',
    rating: 4.7,
  ),
];

class LocalDish {
  final String name;
  final String description;
  final String imageSeed;

  const LocalDish({
    required this.name,
    required this.description,
    required this.imageSeed,
  });
}

const List<LocalDish> bulanDishes = [
  LocalDish(
    name: 'Kinunot na Isda',
    description: 'Local favorite',
    imageSeed: 'kinunot',
  ),
  LocalDish(
    name: 'Ibalaw',
    description: 'Bicolano delicacy',
    imageSeed: 'ibalaw',
  ),
  LocalDish(
    name: 'Pinangat na Isda',
    description: 'Traditional flavor',
    imageSeed: 'pinangat',
  ),
  LocalDish(
    name: 'Kinalas',
    description: 'Hearty & delicious',
    imageSeed: 'kinalas',
  ),
];
