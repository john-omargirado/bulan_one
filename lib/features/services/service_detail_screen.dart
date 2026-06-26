import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';
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
        body: Center(
          child: Text('Service not found.', style: AppTextStyles.body),
        ),
      );
    }

    final isSubmitting = context.watch<ServiceRequestProvider>().isSubmitting;

    return Scaffold(
      appBar: AppBar(title: Text(service.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
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
            const SizedBox(height: AppSpacing.lg),
            Text(service.description, style: AppTextStyles.body),
            const SizedBox(height: AppSpacing.xl),

            Text(
              'Requirements',
              style: AppTextStyles.sectionTitle.copyWith(fontSize: 15),
            ),
            const SizedBox(height: AppSpacing.sm),
            ...service.requirements.map(
              (req) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      size: 16,
                      color: AppColors.statusResolved,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      req,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            Text(
              'Additional notes (optional)',
              style: AppTextStyles.sectionTitle.copyWith(fontSize: 15),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _notesController,
              maxLines: 3,
              style: AppTextStyles.body,
              decoration: InputDecoration(
                hintText: 'Anything we should know about your request?',
                hintStyle: AppTextStyles.caption,
                filled: true,
                fillColor: AppColors.surface,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

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
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Note: requirements above are listed for reference. Bring '
              'original documents when visiting the LGU office for processing.',
              style: AppTextStyles.tiny,
            ),
          ],
        ),
      ),
    );
  }
}
