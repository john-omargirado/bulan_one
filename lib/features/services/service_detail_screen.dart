import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../providers/service_request_provider.dart';
import 'models/service_item.dart';
import 'widgets/service_icon.dart';

class ServiceDetailScreen extends StatefulWidget {
  final String serviceId;

  const ServiceDetailScreen({super.key, required this.serviceId});

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  ServiceItem? get _service {
    try {
      return popularServices.firstWhere((s) => s.id == widget.serviceId);
    } catch (_) {
      return null;
    }
  }

  Future<void> _submit(ServiceItem service) async {
    final provider = context.read<ServiceRequestProvider>();
    final success = await provider.submitRequest(
      serviceId: service.id,
      serviceName: service.name,
      notes: _notesController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Request submitted. We\'ll review it soon.'),
        ),
      );
      context.pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.submitError ?? 'Something went wrong.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final service = _service;

    if (service == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Service')),
        body: const Center(child: Text('Service not found.')),
      );
    }

    final isSubmitting = context.watch<ServiceRequestProvider>().isSubmitting;

    return Scaffold(
      appBar: AppBar(title: Text(service.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.tileBlue,
              child: Icon(
                serviceIconFor(service.icon),
                color: AppColors.primaryNavy,
                size: 28,
              ),
            ),
            const SizedBox(height: 16),
            Text(service.description, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 24),

            const Text(
              'Requirements',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            ...service.requirements.map(
              (req) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      size: 16,
                      color: AppColors.statusResolved,
                    ),
                    const SizedBox(width: 8),
                    Text(req, style: const TextStyle(fontSize: 13)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Additional notes (optional)',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Anything we should know about your request?',
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: isSubmitting ? null : () => _submit(service),
              child: isSubmitting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Submit Request'),
            ),
            const SizedBox(height: 8),
            const Text(
              'Note: requirements above are listed for reference. Bring '
              'original documents when visiting the LGU office for processing.',
              style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
