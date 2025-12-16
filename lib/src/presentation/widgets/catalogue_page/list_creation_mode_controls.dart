import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
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
        return LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              children: [
                AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  curve: defaultCurve,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: state.anyChangesInEditesList
                          ? constraints.maxWidth / 2
                          : constraints.maxWidth,
                    ),
                    child: _Button(
                      color: CustomColors.white,
                      onTap: () {
                        router.pop();
                      },
                      child: Text(
                        LocaleKeys.catalogue_list_creator_back.tr(),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: CustomColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  curve: defaultCurve,
                  child: state.anyChangesInEditesList
                      ? ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: state.anyChangesInEditesList
                                ? constraints.maxWidth / 2
                                : constraints.maxWidth,
                          ),
                          child:
                              BlocBuilder<ListCreatorCubit, ListCreatorState>(
                                buildWhen: (p, c) =>
                                    p.isSavingEditedList !=
                                    c.isSavingEditedList,
                                builder: (context, state) {
                                  return _Button(
                                    color: CustomColors.green,
                                    onTap: () {
                                      creatorCubit.saveEditedList();
                                    },
                                    child: AnimatedSwitcher(
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      switchInCurve: defaultCurve,
                                      switchOutCurve: defaultCurve,
                                      child: state.isSavingEditedList
                                          ? const CustomLoader(
                                              size: 15,
                                              strokeWidth: 2,
                                            )
                                          : Text(
                                              LocaleKeys
                                                  .catalogue_list_creator_save
                                                  .tr(),
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                    color: CustomColors.black,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                    ),
                                  );
                                },
                              ),
                        )
                      : const SizedBox(height: Dimensions.elementHeight),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _Button extends StatelessWidget {
  final Color color;
  final Widget child;
  final VoidCallback onTap;
  const _Button({
    required this.color,
    required this.child,
    required this.onTap,
  });

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [FittedBox(fit: BoxFit.scaleDown, child: child)],
          ),
        ),
      ),
    );
  }
}
