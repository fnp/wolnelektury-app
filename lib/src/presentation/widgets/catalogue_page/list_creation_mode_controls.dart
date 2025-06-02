import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/presentation/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_loader.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/ink_well_wrapper.dart';

class ListCreationModeControls extends StatelessWidget {
  const ListCreationModeControls({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final creatorCubit = BlocProvider.of<ListCreatorCubit>(context);
    return BlocConsumer<ListCreatorCubit, ListCreatorState>(
      listenWhen: (p, c) => p.isSavingEditedList && !c.isSavingEditedList,
      listener: (context, state) {
        if (state.isSavingFailure) {
          CustomSnackbar.error(
            context,
            LocaleKeys.catalogue_list_creator_failure.tr(),
          );
        } else if (state.editedList == null) {
          CustomSnackbar.success(
            context,
            LocaleKeys.catalogue_list_creator_success.tr(),
          );
          router.pop();
        }
      },
      buildWhen: (p, c) => p.anyChangesInEditesList != c.anyChangesInEditesList,
      builder: (context, state) {
        return Row(
          children: [
            _Button(
              color: CustomColors.white,
              onTap: () => router.pop(),
              showBackIcon: true,
              child: Text(
                LocaleKeys.catalogue_list_creator_back.tr(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: CustomColors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (state.anyChangesInEditesList)
              BlocBuilder<ListCreatorCubit, ListCreatorState>(
                buildWhen: (p, c) =>
                    p.isSavingEditedList != c.isSavingEditedList,
                builder: (context, state) {
                  return _Button(
                    color: CustomColors.green,
                    onTap: () {
                      creatorCubit.saveEditedList();
                    },
                    showBackIcon: false,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      switchInCurve: Curves.fastOutSlowIn,
                      switchOutCurve: Curves.fastOutSlowIn,
                      child: state.isSavingEditedList
                          ? const CustomLoader()
                          : Text(
                              LocaleKeys.catalogue_list_creator_save.tr(),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: CustomColors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  );
                },
              ),
          ],
        );
      },
    );
  }
}

class _Button extends StatelessWidget {
  final Color color;
  final Widget child;
  final VoidCallback onTap;
  final bool showBackIcon;
  const _Button({
    required this.color,
    required this.child,
    required this.onTap,
    required this.showBackIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusOfCircle),
        ),
        child: InkWellWrapper(
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusOfCircle),
          onTap: onTap,
          child: SizedBox(
            height: Dimensions.elementHeight,
            child: Stack(
              children: [
                if (showBackIcon)
                  const Positioned(
                    top: 0,
                    bottom: 0,
                    left: Dimensions.largePadding,
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: CustomColors.black,
                    ),
                  ),
                Positioned.fill(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: child,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
