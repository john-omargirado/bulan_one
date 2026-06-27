/// Static service catalog. Promote to Firestore later if the LGU
/// wants to manage service listings without a code deploy.
class ServiceItem {
  final String id;
  final String name;
  final String description;
  final String icon;
  final String category;
  final List<String> requirements;
  final bool isInfoOnly;

  const ServiceItem({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.category,
    required this.requirements,
    this.isInfoOnly = false,
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
    isInfoOnly: true,
  ),
  ServiceItem(
    id: 'maternal_care',
    name: 'Maternal & Child Care',
    description: 'Prenatal checkups and child immunization records',
    icon: 'favorite',
    category: 'Health Services',
    requirements: ['Valid ID', 'Previous medical records (if any)'],
  ),
  ServiceItem(
    id: 'medicine_assistance',
    name: 'Medicine Assistance Program',
    description: 'Request subsidized medicines for qualified residents',
    icon: 'favorite',
    category: 'Health Services',
    requirements: ['Valid ID', 'Proof of residency', 'Doctor\'s prescription'],
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
    id: 'scholarship_status',
    name: 'Check Application Status',
    description: 'Track the status of a submitted scholarship application',
    icon: 'school',
    category: 'Education Services',
    requirements: [],
    isInfoOnly: true,
  ),
  ServiceItem(
    id: 'school_supplies_assistance',
    name: 'School Supplies Assistance',
    description: 'Request school supplies for qualified students',
    icon: 'school',
    category: 'Education Services',
    requirements: [
      'Valid ID',
      'Certificate of enrollment',
      'Proof of residency',
    ],
  ),
  ServiceItem(
    id: 'disaster_preparedness',
    name: 'Disaster Preparedness Guide',
    description: 'Safety tips before, during, and after a disaster',
    icon: 'shield',
    category: 'Disaster & Safety',
    requirements: [],
    isInfoOnly: true,
  ),
  ServiceItem(
    id: 'evacuation_centers',
    name: 'Evacuation Centers',
    description: 'Designated evacuation sites and capacity per barangay',
    icon: 'shield',
    category: 'Disaster & Safety',
    requirements: [],
    isInfoOnly: true,
  ),
  ServiceItem(
    id: 'flood_advisory',
    name: 'Flood & Weather Advisory',
    description: 'Current advisories from MDRRMO and PAGASA',
    icon: 'shield',
    category: 'Disaster & Safety',
    requirements: [],
    isInfoOnly: true,
  ),
  ServiceItem(
    id: 'damage_report',
    name: 'Report Disaster Damage',
    description:
        'Report property or infrastructure damage for assistance assessment',
    icon: 'shield',
    category: 'Disaster & Safety',
    requirements: ['Valid ID', 'Photos of damage (if available)'],
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
    serviceCount: 4,
  ),
  ServiceCategory(
    name: 'Education Services',
    description: 'Scholarships, programs and student assistance',
    icon: 'school',
    serviceCount: 3,
  ),
  ServiceCategory(
    name: 'Transport & Travel',
    description: 'Routes, schedules, and fare information',
    icon: 'directions_bus',
    serviceCount: 0,
  ),
  ServiceCategory(
    name: 'Disaster & Safety',
    description: 'Safety tips, preparedness and assistance',
    icon: 'shield',
    serviceCount: 4,
  ),
];
