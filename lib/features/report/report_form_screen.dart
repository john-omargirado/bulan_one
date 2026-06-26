import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';
import '../../data/models/report.dart';
import '../../providers/report_provider.dart';
import 'widgets/category_picker.dart';
import 'widgets/photo_picker_field.dart';
import 'widgets/location_picker_field.dart';

class ReportFormScreen extends StatefulWidget {
  const ReportFormScreen({super.key});

  @override
  State<ReportFormScreen> createState() => _ReportFormScreenState();
}

class _ReportFormScreenState extends State<ReportFormScreen> {
  final _descriptionController = TextEditingController();
  final _barangayController = TextEditingController();

  ReportCategory? _category;
  File? _photo;
  LocationResult? _location;

  @override
  void dispose() {
    _descriptionController.dispose();
    _barangayController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final provider = context.read<ReportProvider>();

    final success = await provider.submitReport(
      category: _category!,
      description: _descriptionController.text.trim(),
      barangay: _barangayController.text.trim(),
      lat: _location!.lat,
      lng: _location!.lng,
      photo: _photo,
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Report submitted. Thank you!')),
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
    final isSubmitting = context.watch<ReportProvider>().isSubmitting;

    return Scaffold(
      appBar: AppBar(title: const Text('Report an Issue')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Category',
              style: AppTextStyles.sectionTitle.copyWith(fontSize: 15),
            ),
            const SizedBox(height: AppSpacing.sm),
            CategoryPicker(
              selected: _category,
              onSelect: (c) => setState(() => _category = c),
            ),
            const SizedBox(height: AppSpacing.lg),

            Text(
              'Barangay',
              style: AppTextStyles.sectionTitle.copyWith(fontSize: 15),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _barangayController,
              style: AppTextStyles.body,
              decoration: InputDecoration(
                hintText: 'e.g. Brgy. Bacay',
                hintStyle: AppTextStyles.caption,
                filled: true,
                fillColor: AppColors.surface,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            Text(
              'Description',
              style: AppTextStyles.sectionTitle.copyWith(fontSize: 15),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              style: AppTextStyles.body,
              decoration: InputDecoration(
                hintText: 'Describe the issue...',
                hintStyle: AppTextStyles.caption,
                filled: true,
                fillColor: AppColors.surface,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            Text(
              'Photo',
              style: AppTextStyles.sectionTitle.copyWith(fontSize: 15),
            ),
            const SizedBox(height: AppSpacing.sm),
            PhotoPickerField(
              photo: _photo,
              onChanged: (file) => setState(() => _photo = file),
            ),
            const SizedBox(height: AppSpacing.lg),

            Text(
              'Location',
              style: AppTextStyles.sectionTitle.copyWith(fontSize: 15),
            ),
            const SizedBox(height: AppSpacing.sm),
            LocationPickerField(
              onChanged: (loc) => setState(() => _location = loc),
            ),
            const SizedBox(height: AppSpacing.xxl),

            AnimatedBuilder(
              animation: Listenable.merge([
                _descriptionController,
                _barangayController,
              ]),
              builder: (context, _) {
                final canSubmit =
                    _category != null &&
                    _descriptionController.text.trim().isNotEmpty &&
                    _barangayController.text.trim().isNotEmpty &&
                    _location != null;

                return ElevatedButton(
                  onPressed: (canSubmit && !isSubmitting) ? _submit : null,
                  child: isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Submit Report'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
