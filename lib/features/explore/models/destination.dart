enum ExploreFilter { all, nature, attractions, culture, food, stay }

class Destination {
  final String name;
  final String category; // display subtitle, e.g. "Nature & Adventure"
  final String imageSeed;
  final double rating;
  final ExploreFilter filter;

  const Destination({
    required this.name,
    required this.category,
    required this.imageSeed,
    required this.rating,
    required this.filter,
  });
}

const List<Destination> bulanDestinations = [
  Destination(
    name: 'Bulan Eco Park',
    category: 'Nature & Adventure',
    imageSeed: 'bulan-eco-park',
    rating: 4.6,
    filter: ExploreFilter.nature,
  ),
  Destination(
    name: 'Bariis Lake',
    category: 'Nature Escape',
    imageSeed: 'bariis-lake',
    rating: 4.5,
    filter: ExploreFilter.nature,
  ),
  Destination(
    name: 'Sabang Beach',
    category: 'Beach Destination',
    imageSeed: 'sabang-beach',
    rating: 4.4,
    filter: ExploreFilter.attractions,
  ),
  Destination(
    name: 'Bulan Freedom Park',
    category: 'History & Heritage',
    imageSeed: 'freedom-park',
    rating: 4.7,
    filter: ExploreFilter.culture,
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
