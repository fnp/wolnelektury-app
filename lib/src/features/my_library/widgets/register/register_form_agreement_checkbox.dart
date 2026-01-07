import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/domain/register_agreement_model.dart';
import 'package:wolnelektury/src/features/common/cubits/auth/auth_cubit.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/ink_well_wrapper.dart';

class MyLibraryRegisterFormAgreementCheckbox extends StatelessWidget {
  const MyLibraryRegisterFormAgreementCheckbox({
    super.key,
    required this.agreement,
    required this.isError,
  });

  final SingleRegisterAgreementModel agreement;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWellWrapper(
      onTap: () {
        BlocProvider.of<AuthCubit>(context).toggleAgreement(agreement.id);
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.only(
          top: Dimensions.mediumPadding,
          left: Dimensions.mediumPadding,
          bottom: Dimensions.mediumPadding,
        ),
        child: BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (p, c) =>
              p.isAgreementChecked(agreement.id) !=
              c.isAgreementChecked(agreement.id),
          builder: (context, state) {
            return IgnorePointer(
              child: Row(
                children: [
                  SizedBox.square(
                    dimension: Dimensions.elementHeight / 2,
                    child: Checkbox(
                      isError:
                          isError && !state.isAgreementChecked(agreement.id),
                      side: BorderSide(
                        color:
                            isError && !state.isAgreementChecked(agreement.id)
                            ? CustomColors.red
                            : CustomColors.secondaryBlueColor,
                        width: 2,
                      ),
                      fillColor: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.error)) {
                          return CustomColors.red.withValues(alpha: 0.2);
                        }
                        if (states.contains(WidgetState.disabled)) {
                          return Colors.transparent;
                        }
                        if (states.contains(WidgetState.selected)) {
                          return CustomColors.primaryYellowColor;
                        }
                        return null;
                      }),
                      visualDensity: VisualDensity.compact,
                      value: state.isAgreementChecked(agreement.id),
                      onChanged: (_) {},
                    ),
                  ),
                  const SizedBox(width: Dimensions.mediumPadding),
                  Expanded(
                    child: Text(
                      agreement.html,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
