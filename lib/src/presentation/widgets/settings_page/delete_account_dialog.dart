import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/presentation/cubits/auth/auth_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/settings/settings_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/animated/animated_box_fade.dart';
import 'package:wolnelektury/src/presentation/widgets/common/dialog_wrapper.dart';
import 'package:wolnelektury/src/utils/ui/custom_loader.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  static void show({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (builderContext) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<SettingsCubit>()),
          BlocProvider.value(value: context.read<AuthCubit>()),
        ],
        child: BlocListener<SettingsCubit, SettingsState>(
          listenWhen: (p, c) {
            return p.isDeletingAccountSuccess != c.isDeletingAccountSuccess;
          },
          listener: (context, state) {
            if (state.isDeletingAccountSuccess == true) {
              Navigator.of(builderContext).pop();
              CustomSnackbar.success(
                context,
                LocaleKeys.settings_delete_account_success.tr(),
              );
            } else if (state.isDeletingAccountSuccess == false) {
              CustomSnackbar.error(
                context,
                LocaleKeys.settings_delete_account_error.tr(),
              );
            }
          },
          child: const DeleteAccountDialog(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DialogWrapper(
      title: LocaleKeys.settings_delete_account_title.tr().toUpperCase(),
      icon: Icons.delete_forever,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.settings_delete_account_content.tr(),
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: Dimensions.spacer),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: Dimensions.mediumPadding,
            children: [
              ElevatedButton(
                style: yellowElevatedButton,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  LocaleKeys.settings_delete_account_cancel.tr(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<SettingsCubit, SettingsState>(
                  buildWhen: (p, c) =>
                      p.isDeletingAccount != c.isDeletingAccount,
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        context.read<SettingsCubit>().deleteAccount();
                      },
                      child: AnimatedBoxFade(
                        isChildVisible: !state.isDeletingAccount,
                        duration: const Duration(milliseconds: 300),
                        collapsedChild: CustomLoader(
                          size: 20,
                          strokeWidth: 2,
                          color: theme.colorScheme.onError,
                        ),
                        child: Text(
                          LocaleKeys.settings_delete_account_button.tr(),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onError,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
