import 'dart:async';
import 'package:flutter/foundation.dart';

import '../data/models/announcement.dart';
import '../data/repositories/announcement_repository.dart';

class AnnouncementProvider extends ChangeNotifier {
  final AnnouncementRepository _repository;
  StreamSubscription<List<Announcement>>? _subscription;

  AnnouncementProvider(this._repository) {
    _subscription = _repository.watchAll().listen((items) {
      _announcements = items;
      _isLoading = false;
      notifyListeners();
    });
  }

  List<Announcement> _announcements = [];
  List<Announcement> get announcements => _announcements;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
