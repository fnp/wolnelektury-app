import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/presentation/cubits/donation/donation_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/dialog_wrapper.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_loader.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class DonationDialog extends StatelessWidget {
  const DonationDialog({super.key});

  static void show(BuildContext context) {
    showDialog(context: context, builder: (_) => const DonationDialog());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => DonationCubit(get.get()),
      child: Builder(
        builder: (context) {
          return DialogWrapper(
            title: LocaleKeys.donation_title.tr().toUpperCase(),
            icon: Icons.savings,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  LocaleKeys.donation_content_1,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ).tr(),
                const SizedBox(height: Dimensions.mediumPadding),
                Text(
                  LocaleKeys.donation_content_2,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ).tr(),
                const SizedBox(height: Dimensions.spacer),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: yellowElevatedButton,
                        onPressed: () {
                          BlocProvider.of<DonationCubit>(
                            context,
                          ).makeDonation();
                        },
                        child: BlocBuilder<DonationCubit, DonationState>(
                          buildWhen: (p, c) {
                            return p.isLoading != c.isLoading;
                          },
                          builder: (context, state) {
                            if (state.isLoading) {
                              return const SizedBox(
                                width: 15,
                                height: 15,
                                child: CustomLoader(
                                  strokeWidth: 2,
                                  size: 15,
                                  color: CustomColors.black,
                                ),
                              );
                            }
                            return Text(
                              LocaleKeys.donation_button.tr(),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: CustomColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
