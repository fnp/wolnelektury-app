import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/presentation/cubits/reading_page/reading_page_cubit.dart';
import 'package:wolnelektury/src/presentation/enums/reader_font_type.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';
import 'package:wolnelektury/src/utils/ui/ink_well_wrapper.dart';

class ReadingPageSettingsFontStyle extends StatelessWidget {
  const ReadingPageSettingsFontStyle({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ReadingPageCubit>(context);
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final elementWidth =
            constraints.maxWidth / 2 - Dimensions.smallPadding * 2;
        return SizedBox(
          height: Dimensions.elementHeight,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Dimensions.borderRadiusOfCircle,
                    ),
                    color: CustomColors.white,
                  ),
                ),
              ),
              BlocBuilder<ReadingPageCubit, ReadingPageState>(
                buildWhen: (p, c) => p.fontType != c.fontType,
                builder: (context, state) {
                  return AnimatedPositioned(
                    curve: defaultCurve,
                    left: state.fontType == ReaderFontType.sans
                        ? 0
                        : elementWidth + Dimensions.smallPadding * 2,
                    duration: const Duration(milliseconds: 200),
                    child: Padding(
                      padding: const EdgeInsets.all(Dimensions.smallPadding),
                      child: SizedBox(
                        height: 30,
                        width: elementWidth,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Dimensions.borderRadiusOfCircle,
                            ),
                            color: CustomColors.primaryYellowColor,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              BlocBuilder<ReadingPageCubit, ReadingPageState>(
                buildWhen: (p, c) => p.fontType != c.fontType,
                builder: (context, state) {
                  return Positioned.fill(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            // InkWellWrapper's padding
                            padding: const EdgeInsets.only(
                              left: Dimensions.smallPadding,
                              right: Dimensions.smallPadding / 2,
                            ),
                            child: InkWellWrapper(
                              borderRadius: BorderRadius.circular(
                                Dimensions.borderRadiusOfCircle,
                              ),
                              onTap: () {
                                cubit.changeFontType(ReaderFontType.sans);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(
                                  Dimensions.smallPadding,
                                ),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.center,
                                  child: Text(
                                    LocaleKeys.reader_settings_sans.tr(),
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color:
                                          state.fontType == ReaderFontType.sans
                                          ? CustomColors.black
                                          : CustomColors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: Dimensions.smallPadding),
                        Expanded(
                          child: Padding(
                            // InkWellWrapper's padding
                            padding: const EdgeInsets.only(
                              left: Dimensions.smallPadding,
                              right: Dimensions.smallPadding / 2,
                            ),
                            child: InkWellWrapper(
                              borderRadius: BorderRadius.circular(
                                Dimensions.borderRadiusOfCircle,
                              ),
                              onTap: () {
                                cubit.changeFontType(ReaderFontType.serif);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(
                                  Dimensions.smallPadding,
                                ),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.center,
                                  child: Text(
                                    LocaleKeys.reader_settings_serif.tr(),
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontFamily: sourceSerif4Family,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          state.fontType == ReaderFontType.serif
                                          ? CustomColors.black
                                          : CustomColors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
