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
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.tileBlue,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                serviceIconFor(service.icon),
                color: AppColors.primaryNavy,
                size: 26,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(service.description, style: AppTextStyles.body),
            const SizedBox(height: AppSpacing.xl),

            if (service.isInfoOnly) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.tileBlue,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primaryNavy.withValues(alpha: 0.15),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.info_outline,
                      size: 20,
                      color: AppColors.primaryNavy,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        'This is reference information \u2014 no request needed. '
                        'Contact the relevant office directly for the latest updates.',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primaryNavy,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
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
                        Icons.check_circle,
                        size: 16,
                        color: AppColors.statusResolved,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          req,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textPrimary,
                          ),
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.black.withValues(alpha: 0.1),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: isSubmitting ? null : () => _submit(service),
                  icon: isSubmitting
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.send_outlined, size: 18),
                  label: Text(
                    isSubmitting ? 'Submitting...' : 'Submit Request',
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Requirements above are for reference. Bring original '
                'documents when visiting the LGU office for processing.',
                style: AppTextStyles.tiny,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
