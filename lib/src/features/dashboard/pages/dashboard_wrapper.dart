import 'package:flutter/material.dart';
import 'package:wolnelektury/src/features/audiobooks/widgets/audio_minimized_widget.dart';
import 'package:wolnelektury/src/features/dashboard/widgets/dashboard_app_bar.dart';
import 'package:wolnelektury/src/features/dashboard/widgets/dashboard_bottom_bar.dart';
import 'package:wolnelektury/src/features/dashboard/widgets/dashboard_listeners.dart';
import 'package:wolnelektury/src/features/dashboard/widgets/dashboard_no_connection.dart';
import 'package:wolnelektury/src/features/dashboard/widgets/dashboard_providers.dart';

class DashboardWrapper extends StatelessWidget {
  const DashboardWrapper({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DashboardProviders(
      child: DashboardListeners(
        child: DashboardConnectionWrapper(
          scaffold: Scaffold(
            backgroundColor: theme.colorScheme.surface,
            appBar: const DashboardAppBar(),
            body: SafeArea(
              top: true,
              child: Stack(children: [child, const AudioMinimizedWidget()]),
            ),
            bottomNavigationBar: const DashboardBottomBar(),
          ),
        ),
      ),
    );
  }
}
