import 'dart:async';
import 'package:flutter/foundation.dart';

import '../data/models/office.dart';
import '../data/repositories/office_repository.dart';

class OfficeProvider extends ChangeNotifier {
  final OfficeRepository _repository;
  StreamSubscription<List<Office>>? _subscription;

  OfficeProvider(this._repository) {
    _subscription = _repository.watchAll().listen((items) {
      _offices = items;
      _isLoading = false;
      notifyListeners();
    });
  }

  List<Office> _offices = [];
  List<Office> get offices => _offices;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
