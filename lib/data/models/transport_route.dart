enum TransportMode { land, water }

/// A transport route with real origin/destination coordinates so it
/// can be rendered on a map, plus schedule and fare info.
/// Fare/hours below are PLACEHOLDERS \u2014 replace with real data once verified.
class TransportRoute {
  final String id;
  final String name; // e.g. "Bulan \u2192 Sorsogon City"
  final TransportMode mode;
  final String vehicleType; // "Bus", "Van", "Tricycle", "Passenger Boat"
  final double originLat;
  final double originLng;
  final String originName;
  final double destLat;
  final double destLng;
  final String destName;
  final String hours; // e.g. "5:00 AM \u2013 6:00 PM, every 30 mins"
  final String fare; // e.g. "PLACEHOLDER - VERIFY"

  const TransportRoute({
    required this.id,
    required this.name,
    required this.mode,
    required this.vehicleType,
    required this.originLat,
    required this.originLng,
    required this.originName,
    required this.destLat,
    required this.destLng,
    required this.destName,
    required this.hours,
    required this.fare,
  });
}

// Bulan Terminal coordinates reused as the common origin point for
// land routes \u2014 same Municipal Hall area coordinates we verified earlier.
const double _bulanTerminalLat = 12.6677;
const double _bulanTerminalLng = 123.8775;

const List<TransportRoute> landRoutes = [
  TransportRoute(
    id: 'bulan_sorsogon',
    name: 'Bulan \u2192 Sorsogon City',
    mode: TransportMode.land,
    vehicleType: 'Van/Bus',
    originLat: _bulanTerminalLat,
    originLng: _bulanTerminalLng,
    originName: 'Bulan Terminal',
    destLat: 12.9750,
    destLng: 124.0067,
    destName: 'Sorsogon City',
    hours: 'PLACEHOLDER - VERIFY',
    fare: 'PLACEHOLDER - VERIFY',
  ),
  TransportRoute(
    id: 'bulan_irosin',
    name: 'Bulan \u2192 Irosin',
    mode: TransportMode.land,
    vehicleType: 'Van',
    originLat: _bulanTerminalLat,
    originLng: _bulanTerminalLng,
    originName: 'Bulan Terminal',
    destLat: 12.7039,
    destLng: 123.9075,
    destName: 'Irosin',
    hours: 'PLACEHOLDER - VERIFY',
    fare: 'PLACEHOLDER - VERIFY',
  ),
];

const List<TransportRoute> waterRoutes = [
  TransportRoute(
    id: 'bulan_masbate',
    name: 'Bulan \u2192 Masbate',
    mode: TransportMode.water,
    vehicleType: 'Passenger Boat',
    originLat: 12.6650,
    originLng:
        123.8700, // approximate Bulan port, VERIFY exact pier coordinates
    originName: 'Bulan Port',
    destLat: 12.3686,
    destLng: 123.6222,
    destName: 'Masbate City',
    hours: 'PLACEHOLDER - VERIFY',
    fare: 'PLACEHOLDER - VERIFY',
  ),
];
