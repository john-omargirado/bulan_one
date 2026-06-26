import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/constants/app_text_styles.dart';

class LocationResult {
  final double lat;
  final double lng;
  const LocationResult(this.lat, this.lng);
}

class LocationPickerField extends StatefulWidget {
  final ValueChanged<LocationResult?> onChanged;

  const LocationPickerField({super.key, required this.onChanged});

  @override
  State<LocationPickerField> createState() => _LocationPickerFieldState();
}

class _LocationPickerFieldState extends State<LocationPickerField> {
  bool _isLoading = false;
  LocationResult? _result;
  String? _error;

  Future<void> _captureLocation() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        final requested = await Geolocator.requestPermission();
        if (requested == LocationPermission.denied ||
            requested == LocationPermission.deniedForever) {
          setState(() {
            _error = 'Location permission is needed to attach your location.';
            _isLoading = false;
          });
          return;
        }
      }

      final position =
          await Geolocator.getCurrentPosition(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.high,
            ),
          ).timeout(
            const Duration(seconds: 10),
            onTimeout: () =>
                throw TimeoutException('Location request timed out'),
          );

      final result = LocationResult(position.latitude, position.longitude);
      setState(() {
        _result = result;
        _isLoading = false;
      });
      widget.onChanged(result);
    } on TimeoutException {
      setState(() {
        _error =
            'Location request took too long. Try again, or check GPS settings.';
        _isLoading = false;
      });
    } catch (_) {
      setState(() {
        _error = 'Could not get your location. Make sure GPS is enabled.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OutlinedButton.icon(
          onPressed: _isLoading ? null : _captureLocation,
          icon: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.my_location),
          label: Text(
            _result == null ? 'Use my current location' : 'Location captured',
          ),
        ),
        if (_result != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              '${_result!.lat.toStringAsFixed(5)}, ${_result!.lng.toStringAsFixed(5)}',
              style: AppTextStyles.caption,
            ),
          ),
        if (_error != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              _error!,
              style: AppTextStyles.caption.copyWith(color: Colors.red),
            ),
          ),
      ],
    );
  }
}
