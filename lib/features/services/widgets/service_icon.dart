import 'package:flutter/material.dart';

/// Maps a string icon key (from ServiceItem/ServiceCategory) to a
/// real IconData. Keeps the data models free of Flutter imports.
IconData serviceIconFor(String key) {
  switch (key) {
    case 'description':
      return Icons.description_outlined;
    case 'storefront':
      return Icons.storefront_outlined;
    case 'home':
      return Icons.home_outlined;
    case 'receipt':
      return Icons.receipt_long_outlined;
    case 'home_work':
      return Icons.home_work_outlined;
    case 'event':
      return Icons.event_available_outlined;
    case 'account_balance':
      return Icons.account_balance_outlined;
    case 'favorite':
      return Icons.favorite_outline;
    case 'school':
      return Icons.school_outlined;
    case 'directions_bus':
      return Icons.directions_bus_outlined;
    case 'shield':
      return Icons.shield_outlined;
    default:
      return Icons.help_outline;
  }
}
