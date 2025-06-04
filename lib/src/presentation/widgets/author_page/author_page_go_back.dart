import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/presentation/cubits/author/author_cubit.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/ink_well_wrapper.dart';

class AuthorPageGoBack extends StatelessWidget {
  const AuthorPageGoBack({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<AuthorCubit, AuthorState>(
      buildWhen: (p, c) =>
          p.isLoading != c.isLoading ||
          p.isLoadingAuthorsBooks != c.isLoadingAuthorsBooks ||
          p.isLoadingAuthorsTranslations != c.isLoadingAuthorsTranslations,
      builder: (context, state) {
        if (state.isLoading ||
            state.isLoadingAuthorsBooks ||
            state.isLoadingAuthorsTranslations) {
          return const SizedBox.shrink();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimensions.spacer),
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: CustomColors.primaryYellowColor,
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.borderRadiusOfCircle),
              ),
            ),
            child: InkWellWrapper(
              onTap: () {
                router.pop();
              },
              borderRadius: const BorderRadius.all(
                Radius.circular(Dimensions.borderRadiusOfCircle),
              ),
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.mediumPadding),
                child: Row(
                  children: [
                    const Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.arrow_back_ios),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        LocaleKeys.catalogue_author_back.tr(),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: CustomColors.black,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
