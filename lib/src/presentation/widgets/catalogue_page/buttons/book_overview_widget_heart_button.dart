import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/domain/book_model.dart';
import 'package:wolnelektury/src/presentation/cubits/likes/likes_cubit.dart';
import 'package:wolnelektury/src/presentation/enums/my_library_enum.dart';
import 'package:wolnelektury/src/presentation/widgets/catalogue_page/buttons/book_overview_widget_button.dart';
import 'package:wolnelektury/src/presentation/widgets/common/auth_wrapper.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';

class BookOverviewWidgetHeartButton extends StatelessWidget {
  final BookModel book;
  const BookOverviewWidgetHeartButton({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final favouritesCubit = BlocProvider.of<LikesCubit>(context);
    return BlocBuilder<LikesCubit, LikesState>(
      buildWhen: (p, c) => p.favourites != c.favourites,
      builder: (context, state) {
        final isLiked = state.favourites.contains(book.slug);
        return AuthWrapper(
          authChild: (user) {
            return BookOverviewWidgetButton(
              nonActiveBackgroundColor: CustomColors.white,
              activeBackgroundColor: CustomColors.primaryYellowColor,
              nonActiveIcon: CustomIcons.favorite_filled,
              activeIcon: CustomIcons.favorite_filled,
              onTap: () {
                if (isLiked) {
                  favouritesCubit.removeFromFavourites(book.slug);
                  return;
                }

                favouritesCubit.addToFavourites(book.slug);
              },
              isActive: isLiked,
            );
          },
          nonAuthChild: BookOverviewWidgetButton(
            nonActiveBackgroundColor: CustomColors.white,
            nonActiveIcon: CustomIcons.favorite_filled,
            onTap: () {
              CustomSnackbar.success(
                context,
                LocaleKeys.common_snackbar_not_logged.tr(),
                icon: const Icon(
                  CustomIcons.for_you,
                  size: 20,
                  color: CustomColors.black,
                ),
                onTap: () {
                  router.pushNamed(
                    myLibraryPageConfig.name,
                    extra: MyLibraryEnum.login,
                  );
                },
              );
            },
            isActive: false,
          ),
        );
      },
    );
  }
}
