import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/presentation/cubits/list_creator/list_creator_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/custom_button.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';

class BookOverviewWidgetListCreationModeButton extends StatelessWidget {
  final String slug;
  const BookOverviewWidgetListCreationModeButton(this.slug, {super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ListCreatorCubit>(context);
    return BlocBuilder<ListCreatorCubit, ListCreatorState>(
      buildWhen: (p, c) =>
          p.isBookInEditedList(slug) != c.isBookInEditedList(slug),
      builder: (context, state) {
        final isBookInEditedList = state.isBookInEditedList(slug);
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchOutCurve: defaultCurve,
          switchInCurve: defaultCurve,
          transitionBuilder: (child, animation) =>
              ScaleTransition(scale: animation, child: child),
          child: CustomButton(
            key: ValueKey(isBookInEditedList),
            icon: isBookInEditedList ? Icons.check : CustomIcons.add,
            backgroundColor: isBookInEditedList
                ? CustomColors.green
                : CustomColors.white,
            iconColor: CustomColors.black,
            onPressed: () {
              if (isBookInEditedList) {
                cubit.removeBookFromEditedList(slug);
                return;
              }

              cubit.addBookToEditedList(slug);
            },
          ),
        );
      },
    );
  }
}
