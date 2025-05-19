import 'package:flutter/material.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/ink_well_wrapper.dart';

class AuthorPageGoBack extends StatelessWidget {
  const AuthorPageGoBack({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: CustomColors.primaryYellowColor,
        borderRadius: BorderRadius.all(
          Radius.circular(
            Dimensions.borderRadiusOfCircle,
          ),
        ),
      ),
      child: InkWellWrapper(
        onTap: () {
          router.pop();
        },
        borderRadius: const BorderRadius.all(
          Radius.circular(
            Dimensions.borderRadiusOfCircle,
          ),
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
                  'Powrót',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
