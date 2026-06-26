/// Static service catalog. Promote to Firestore later if the LGU
/// wants to manage service listings without a code deploy.
class ServiceItem {
  final String id;
  final String name;
  final String description;
  final String icon; // maps to an IconData in the widget layer
  final String category;
  final List<String> requirements;

  const ServiceItem({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.category,
    required this.requirements,
  });
}

const List<ServiceItem> popularServices = [
  ServiceItem(
    id: 'barangay_clearance',
    name: 'Barangay Clearance',
    description: 'Request your barangay clearance online',
    icon: 'description',
    category: 'Government Services',
    requirements: ['Valid ID', 'Proof of residency'],
  ),
  ServiceItem(
    id: 'business_permit',
    name: 'Business Permit',
    description: 'Apply for new or renew your business permit',
    icon: 'storefront',
    category: 'Government Services',
    requirements: [
      'DTI/SEC registration',
      'Valid ID',
      'Lease contract or land title',
    ],
  ),
  ServiceItem(
    id: 'certificate_residency',
    name: 'Certificate of Residency',
    description: 'Request certificate of residency',
    icon: 'home',
    category: 'Government Services',
    requirements: ['Valid ID', 'Proof of residency'],
  ),
  ServiceItem(
    id: 'community_tax',
    name: 'Community Tax Certificate',
    description: 'Request your community tax certificate',
    icon: 'receipt',
    category: 'Government Services',
    requirements: ['Valid ID'],
  ),
  ServiceItem(
    id: 'real_property_tax',
    name: 'Real Property Tax',
    description: 'View and pay your real property tax',
    icon: 'home_work',
    category: 'Government Services',
    requirements: ['Tax declaration number', 'Valid ID'],
  ),
  ServiceItem(
    id: 'appointment_booking',
    name: 'Appointment Booking',
    description: 'Book an appointment with LGU offices',
    icon: 'event',
    category: 'Government Services',
    requirements: ['Valid ID'],
  ),
  ServiceItem(
    id: 'health_consultation',
    name: 'Health Consultation',
    description: 'Book a consultation at the Rural Health Unit',
    icon: 'favorite',
    category: 'Health Services',
    requirements: ['Valid ID'],
  ),
  ServiceItem(
    id: 'vaccination_schedule',
    name: 'Vaccination Schedule',
    description: 'Check upcoming vaccination drives',
    icon: 'favorite',
    category: 'Health Services',
    requirements: [],
  ),
  ServiceItem(
    id: 'scholarship_application',
    name: 'Scholarship Application',
    description: 'Apply for LGU-funded scholarship programs',
    icon: 'school',
    category: 'Education Services',
    requirements: [
      'Certificate of enrollment',
      'Valid ID',
      'Income certificate',
    ],
  ),
  ServiceItem(
    id: 'transport_schedule',
    name: 'Terminal Schedule',
    description: 'Check bus and van terminal schedules',
    icon: 'directions_bus',
    category: 'Transport & Travel',
    requirements: [],
  ),
  ServiceItem(
    id: 'disaster_preparedness',
    name: 'Disaster Preparedness Guide',
    description: 'Safety tips and evacuation center info',
    icon: 'shield',
    category: 'Disaster & Safety',
    requirements: [],
  ),
];

class ServiceCategory {
  final String name;
  final String description;
  final String icon;
  final int serviceCount;

  const ServiceCategory({
    required this.name,
    required this.description,
    required this.icon,
    required this.serviceCount,
  });
}

const List<ServiceCategory> serviceCategories = [
  ServiceCategory(
    name: 'Government Services',
    description: 'Permits, clearances, certificates and more',
    icon: 'account_balance',
    serviceCount: 12,
  ),
  ServiceCategory(
    name: 'Health Services',
    description: 'Health programs, assistance and appointments',
    icon: 'favorite',
    serviceCount: 8,
  ),
  ServiceCategory(
    name: 'Education Services',
    description: 'Scholarships, programs and student assistance',
    icon: 'school',
    serviceCount: 6,
  ),
  ServiceCategory(
    name: 'Transport & Travel',
    description: 'Public transport, terminals and travel info',
    icon: 'directions_bus',
    serviceCount: 5,
  ),
  ServiceCategory(
    name: 'Disaster & Safety',
    description: 'Safety tips, preparedness and assistance',
    icon: 'shield',
    serviceCount: 4,
  ),
];
