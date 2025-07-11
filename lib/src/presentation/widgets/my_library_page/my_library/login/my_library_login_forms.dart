import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/presentation/cubits/auth/auth_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/custom_scroll_page.dart';
import 'package:wolnelektury/src/presentation/widgets/common/page_subtitle.dart';
import 'package:wolnelektury/src/presentation/widgets/my_library_page/my_library/login/my_library_login_form.dart';
import 'package:wolnelektury/src/presentation/widgets/my_library_page/my_library/login/my_library_register_form.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class MyLibraryMyLibraryLoginForms extends StatelessWidget {
  const MyLibraryMyLibraryLoginForms({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.mediumPadding),
      child: BlocBuilder<AuthCubit, AuthState>(
        buildWhen: (p, c) {
          return p.shouldShowRegisterForm != c.shouldShowRegisterForm;
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageSubtitle(
                subtitle:
                    (state.shouldShowRegisterForm
                            ? LocaleKeys.login_register
                            : LocaleKeys.login_title)
                        .tr(),
              ),
              Expanded(
                child: CustomScrollPage(
                  builder: (scrollController) {
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: scrollController,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        reverseDuration: const Duration(milliseconds: 300),
                        switchInCurve: Curves.fastOutSlowIn,
                        switchOutCurve: Curves.fastOutSlowIn,
                        layoutBuilder: (currentChild, previousChildren) {
                          return Stack(
                            alignment: Alignment.topCenter,
                            children: <Widget>[
                              ...previousChildren,
                              if (currentChild != null) currentChild,
                            ],
                          );
                        },
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                        child: state.shouldShowRegisterForm
                            ? MyLibraryRegisterForm(
                                key: const ValueKey('register'),
                                onLogin: () => authCubit.switchUi(false),
                              )
                            : MyLibraryLoginForm(
                                key: const ValueKey('login'),
                                onRegister: () => authCubit.switchUi(true),
                              ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
