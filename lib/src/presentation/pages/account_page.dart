import 'package:flutter/material.dart';
import 'package:wolnelektury/src/presentation/widgets/account_page/login_form.dart';
import 'package:wolnelektury/src/presentation/widgets/account_page/my_library/my_library_page.dart';
import 'package:wolnelektury/src/presentation/widgets/account_page/register_form.dart';
import 'package:wolnelektury/src/presentation/widgets/common/auth_wrapper.dart';
import 'package:wolnelektury/src/presentation/widgets/common/connectivity_wrapper.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: ConnectivityWrapper(
        builder: (context, hasConnection) {
          if (!hasConnection) {
            return const MyLibraryPage(isOfflineMode: true);
          }
          return AuthWrapper(
            authChild: (_) => const MyLibraryPage(isOfflineMode: false),
            nonAuthChild: const _Forms(),
          );
        },
      ),
    );
  }
}

class _Forms extends StatefulWidget {
  const _Forms();

  @override
  State<_Forms> createState() => _FormsState();
}

class _FormsState extends State<_Forms> {
  @override
  Widget build(BuildContext context) {
    final pageViewController = PageController();

    return LayoutBuilder(
      builder: (context, constraints) {
        return PageView(
          controller: pageViewController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SingleChildScrollView(
              child: LoginForm(
                onRegister: () {
                  pageViewController.nextPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.ease,
                  );
                },
              ),
            ),
            SingleChildScrollView(
              child: RegisterForm(
                maxHeightConstraint: constraints.maxHeight,
                onLogin: () {
                  pageViewController.previousPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.ease,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
