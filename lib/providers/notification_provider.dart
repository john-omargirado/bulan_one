import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/app_notification.dart';
import '../data/repositories/notification_repository.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationRepository _repository;
  StreamSubscription<List<AppNotification>>? _subscription;
  static const _lastSeenKey = 'notifications_last_seen';

  NotificationProvider(this._repository) {
    _init();
  }

  List<AppNotification> _notifications = [];
  List<AppNotification> get notifications => _notifications;

  DateTime? _lastSeen;

  int get unreadCount {
    if (_lastSeen == null) return _notifications.length;
    return _notifications.where((n) => n.createdAt.isAfter(_lastSeen!)).length;
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    final lastSeenMillis = prefs.getInt(_lastSeenKey);
    _lastSeen = lastSeenMillis != null
        ? DateTime.fromMillisecondsSinceEpoch(lastSeenMillis)
        : null;

    _subscription = _repository.watchAll().listen((items) {
      _notifications = items;
      notifyListeners();
    });
  }

  Future<void> markAllSeen() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    await prefs.setInt(_lastSeenKey, now.millisecondsSinceEpoch);
    _lastSeen = now;
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
