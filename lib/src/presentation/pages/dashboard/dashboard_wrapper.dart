import 'package:flutter/material.dart';
import 'package:wolnelektury/src/presentation/pages/dashboard/dashboard_listeners.dart';
import 'package:wolnelektury/src/presentation/pages/dashboard/dashboard_no_connection.dart';
import 'package:wolnelektury/src/presentation/pages/dashboard/dashboard_providers.dart';
import 'package:wolnelektury/src/presentation/widgets/audio_dialog/audio_minimized_widget.dart';
import 'package:wolnelektury/src/presentation/widgets/dashboard_page/dashboard_app_bar.dart';
import 'package:wolnelektury/src/presentation/widgets/dashboard_page/dashboard_bottom_bar.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

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
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(Dimensions.appBarHeight),
              child: DashboardAppBar(),
            ),
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
