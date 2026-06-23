import 'dart:async';
import 'package:flutter/foundation.dart';

import '../data/models/hotline.dart';
import '../data/repositories/hotline_repository.dart';

class HotlineProvider extends ChangeNotifier {
  final HotlineRepository _repository;
  StreamSubscription<List<Hotline>>? _subscription;

  HotlineProvider(this._repository) {
    _subscription = _repository.watchAll().listen((items) {
      _hotlines = items;
      _isLoading = false;
      notifyListeners();
    });
  }

  List<Hotline> _hotlines = [];
  List<Hotline> get hotlines => _hotlines;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
