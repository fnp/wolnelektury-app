import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/features/common/widgets/button/custom_button.dart';
import 'package:wolnelektury/src/features/lists/cubits/list_creator/list_creator_cubit.dart';
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
    final creatorCubit = context.read<ListCreatorCubit>();
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Dimensions.modalsBorderRadius),
          topRight: Radius.circular(Dimensions.modalsBorderRadius),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: Dimensions.largePadding,
          left: Dimensions.mediumPadding,
          right: Dimensions.mediumPadding,
          bottom: Dimensions.modalsPadding,
        ),
        child: BlocConsumer<ListCreatorCubit, ListCreatorState>(
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
          buildWhen: (p, c) {
            return p.numberOfChangesInEditedList !=
                c.numberOfChangesInEditedList;
          },
          builder: (context, state) {
            return Row(
              spacing: Dimensions.mediumPadding,
              children: [
                CustomButton(
                  semanticLabel: LocaleKeys.catalogue_list_creator_back.tr(),
                  icon: Icons.arrow_back,
                  backgroundColor: CustomColors.white,
                  iconColor: CustomColors.black,
                  onPressed: () {
                    router.pop();
                  },
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  curve: defaultCurve,
                  opacity: state.numberOfChangesInEditedList > 0 ? 1 : 0.5,
                  child: CustomButton(
                    semanticLabel: LocaleKeys.catalogue_list_creator_back.tr(),
                    icon: Icons.history,
                    backgroundColor: CustomColors.white,
                    iconColor: CustomColors.black,
                    onPressed: () {
                      creatorCubit.restoreListToItsPreviousState();
                    },
                  ),
                ),
                Expanded(
                  child: _SaveButton(
                    numberOfChanges: state.numberOfChangesInEditedList,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final int numberOfChanges;
  const _SaveButton({required this.numberOfChanges});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final creatorCubit = context.read<ListCreatorCubit>();
    final isDisabled = numberOfChanges == 0;
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: defaultCurve,
      child: BlocBuilder<ListCreatorCubit, ListCreatorState>(
        buildWhen: (p, c) {
          return p.isSavingEditedList != c.isSavingEditedList;
        },
        builder: (context, state) {
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            curve: defaultCurve,
            opacity: isDisabled ? 0.5 : 1,
            child: _Button(
              color: CustomColors.green,
              onTap: () {
                creatorCubit.saveEditedList();
              },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                switchInCurve: defaultCurve,
                switchOutCurve: defaultCurve,
                child: state.isSavingEditedList
                    ? const CustomLoader(size: 15, strokeWidth: 2)
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.mediumPadding,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const SizedBox(width: Dimensions.largePadding),
                            Expanded(
                              child: Text(
                                LocaleKeys.catalogue_list_creator_save.tr(),
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: CustomColors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            _NumberOfChanges(numberOfChanges: numberOfChanges),
                          ],
                        ),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _NumberOfChanges extends StatelessWidget {
  final int numberOfChanges;
  const _NumberOfChanges({required this.numberOfChanges});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox.square(
      dimension: Dimensions.elementHeight - 15,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: CustomColors.white,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Text(
                numberOfChanges.toString(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: CustomColors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final Color color;
  final Widget child;
  final VoidCallback? onTap;
  const _Button({required this.color, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusOfCircle),
      ),
      child: InkWellWrapper(
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusOfCircle),
        onTap: onTap,
        child: SizedBox(
          height: Dimensions.elementHeight,
          child: Center(child: child),
        ),
      ),
    );
  }
}
