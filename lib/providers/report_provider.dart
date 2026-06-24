import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data/models/report.dart';
import '../data/repositories/report_repository.dart';

class ReportProvider extends ChangeNotifier {
  final ReportRepository _repository;
  StreamSubscription<List<Report>>? _subscription;

  ReportProvider(this._repository) {
    _listenToMyReports();
  }

  List<Report> _myReports = [];
  List<Report> get myReports => _myReports;

  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  String? _submitError;
  String? get submitError => _submitError;

  /// The current device's stable identity, backed by Firebase
  /// anonymous auth rather than a locally-generated UUID. This is
  /// what lets Firestore security rules actually verify ownership.
  String get _uid {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw StateError(
        'No authenticated user. Anonymous sign-in should have run in main().',
      );
    }
    return user.uid;
  }

  void _listenToMyReports() {
    _subscription = _repository.watchMyReports(_uid).listen((reports) {
      _myReports = reports;
      notifyListeners();
    });
  }

  Future<bool> submitReport({
    required ReportCategory category,
    required String description,
    required double lat,
    required double lng,
    required String barangay,
    File? photo,
  }) async {
    _isSubmitting = true;
    _submitError = null;
    notifyListeners();

    try {
      String? photoUrl;
      if (photo != null) {
        photoUrl = await _repository
            .uploadPhoto(photo, _uid)
            .timeout(
              const Duration(
                seconds: 20,
              ), // photo upload can take longer than text
              onTimeout: () {
                throw TimeoutException('Photo upload timed out');
              },
            );
      }

      final report = Report(
        deviceId: _uid,
        category: category,
        description: description,
        photoUrl: photoUrl,
        lat: lat,
        lng: lng,
        barangay: barangay,
        createdAt: DateTime.now(),
      );

      await _repository
          .submit(report)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw TimeoutException('Report submission timed out');
            },
          );

      _isSubmitting = false;
      notifyListeners();
      return true;
    } on TimeoutException {
      _isSubmitting = false;
      _submitError =
          'This is taking too long. Check your connection and try again.';
      notifyListeners();
      return false;
    } catch (e) {
      _isSubmitting = false;
      _submitError =
          'Could not submit report. Please check your connection and try again.';
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
