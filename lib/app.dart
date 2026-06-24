import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

import 'data/repositories/report_repository.dart';
import 'data/repositories/announcement_repository.dart';
import 'data/repositories/hotline_repository.dart';
import 'data/repositories/office_repository.dart';

import 'providers/report_provider.dart';
import 'providers/announcement_provider.dart';
import 'providers/hotline_provider.dart';
import 'providers/office_provider.dart';

import 'data/repositories/service_request_repository.dart';
import 'providers/service_request_provider.dart';

/// Root widget. Wires repositories -> providers -> router.
/// Repositories are created once here and never touched outside
/// this file and the providers that wrap them.
class BulanApp extends StatelessWidget {
  const BulanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Repositories (no UI dependency, just data access)
        Provider(create: (_) => ReportRepository()),
        Provider(create: (_) => AnnouncementRepository()),
        Provider(create: (_) => HotlineRepository()),
        Provider(create: (_) => OfficeRepository()),
        Provider(
          create: (_) => ServiceRequestRepository(),
        ), // <-- ADD THIS LINE
        // ChangeNotifier providers that screens actually listen to
        ChangeNotifierProvider(
          create: (ctx) => ReportProvider(ctx.read<ReportRepository>()),
        ),
        ChangeNotifierProvider(
          create: (ctx) =>
              AnnouncementProvider(ctx.read<AnnouncementRepository>()),
        ),
        ChangeNotifierProvider(
          create: (ctx) => HotlineProvider(ctx.read<HotlineRepository>()),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OfficeProvider(ctx.read<OfficeRepository>()),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ServiceRequestProvider(
            ctx.read<ServiceRequestRepository>(),
          ), // <-- MOVED HERE
        ),
      ],
      child: MaterialApp.router(
        title: 'Bulan One App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
