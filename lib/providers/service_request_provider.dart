import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data/models/service_request.dart';
import '../data/repositories/service_request_repository.dart';

class ServiceRequestProvider extends ChangeNotifier {
  final ServiceRequestRepository _repository;
  StreamSubscription<List<ServiceRequest>>? _subscription;

  ServiceRequestProvider(this._repository) {
    _listenToMyRequests();
  }

  List<ServiceRequest> _myRequests = [];
  List<ServiceRequest> get myRequests => _myRequests;

  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

  String? _submitError;
  String? get submitError => _submitError;

  String get _uid {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw StateError('No authenticated user.');
    }
    return user.uid;
  }

  void _listenToMyRequests() {
    _subscription = _repository.watchMyRequests(_uid).listen((requests) {
      _myRequests = requests;
      notifyListeners();
    });
  }

  Future<bool> submitRequest({
    required String serviceId,
    required String serviceName,
    required String notes,
  }) async {
    _isSubmitting = true;
    _submitError = null;
    notifyListeners();

    try {
      final request = ServiceRequest(
        uid: _uid,
        serviceId: serviceId,
        serviceName: serviceName,
        notes: notes,
        createdAt: DateTime.now(),
      );

      await _repository
          .submit(request)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw TimeoutException('Request submission timed out');
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
          'Could not submit request. Please check your connection and try again.';
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
