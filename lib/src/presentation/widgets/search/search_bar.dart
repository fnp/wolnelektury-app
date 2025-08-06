import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/presentation/cubits/search/search_cubit.dart';
import 'package:wolnelektury/src/presentation/widgets/common/button/custom_button.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar> {
  final TextEditingController controller = TextEditingController();
  late ThemeData theme;
  bool isEmpty = true;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    theme = Theme.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final searchCubit = context.read<SearchCubit>();
    return Row(
      spacing: Dimensions.mediumPadding,
      children: [
        Expanded(
          child: SizedBox(
            height: Dimensions.elementHeight,
            child: TextField(
              autofocus: true,
              textInputAction: TextInputAction.done,
              controller: controller,
              onChanged: (value) {
                searchCubit.changeQuery(value);
                setState(() {
                  isEmpty = value.trim().isEmpty;
                });
              },
              style: theme.textTheme.bodyMedium,
              cursorColor: CustomColors.black,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: Dimensions.smallPadding,
                  horizontal: Dimensions.veryLargePadding,
                ),
                suffixIconColor: CustomColors.black,
                isDense: true,
                fillColor: CustomColors.primaryYellowColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    Dimensions.borderRadiusOfCircle,
                  ),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    Dimensions.borderRadiusOfCircle,
                  ),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    Dimensions.borderRadiusOfCircle,
                  ),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 100),
                  switchInCurve: Curves.fastOutSlowIn,
                  switchOutCurve: Curves.fastOutSlowIn,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: isEmpty
                      ? const SizedBox.square(
                          dimension: 40,
                          child: Align(
                            alignment: Alignment.center,
                            child: Icon(Icons.search, size: 24),
                          ),
                        )
                      : CustomButton(
                          key: const ValueKey('clear_search'),
                          icon: Icons.close,
                          onPressed: () {
                            controller.clear();
                            searchCubit.changeQuery('');
                            setState(() {
                              isEmpty = true;
                            });
                          },
                        ),
                ),
              ),
            ),
          ),
        ),
        CustomButton(
          icon: CustomIcons.close,
          iconColor: theme.colorScheme.onSurface,
          backgroundColor: theme.colorScheme.tertiaryContainer,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
