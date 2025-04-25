import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/router/router_config.dart';
import 'package:wolnelektury/src/presentation/widgets/common/auth_wrapper.dart';
import 'package:wolnelektury/src/presentation/widgets/common/custom_scroll_page.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class UserWidget extends StatefulWidget {
  const UserWidget({super.key});

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  final verticalController = AutoScrollController();
  final horizontalController = AutoScrollController();

  int currentIndex = 0;

  void setIndex({
    required int newIndex,
    required bool shouldScrollVertically,
  }) {
    if (currentIndex == newIndex) {
      return;
    }
    setState(() {
      currentIndex = newIndex;
    });

    horizontalController.scrollToIndex(
      newIndex,
      preferPosition: AutoScrollPosition.middle,
    );

    if (!shouldScrollVertically) {
      return;
    }

    verticalController.scrollToIndex(
      newIndex,
      preferPosition: AutoScrollPosition.begin,
    );
  }

  bool isIndexActive(int index) => currentIndex == index;
  bool isButtonActive = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.veryLargePadding,
        bottom: Dimensions.veryLargePadding,
        right: Dimensions.mediumPadding,
        top: Dimensions.mediumPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AuthWrapper(
                  authChild: (user) => Text(
                    LocaleKeys.account_title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ).tr(namedArgs: {'name': user.username}),
                ),
              ),
              Material(
                color: theme.colorScheme.surface,
                child: InkWell(
                  borderRadius: BorderRadius.circular(
                    Dimensions.smallBorderRadius,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.mediumPadding),
                    child: Icon(
                      Icons.settings_outlined,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  onTap: () {
                    router.pushNamed(settingsPageConfig.name);
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 80,
            child: ListView.builder(
              controller: horizontalController,
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (_, index) => AutoScrollTag(
                key: ValueKey(index),
                controller: horizontalController,
                index: index,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: Dimensions.mediumPadding,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setIndex(newIndex: index, shouldScrollVertically: true);
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: isIndexActive(index)
                          ? theme.colorScheme.secondary
                          : theme.primaryColor,
                      child: Text(
                        index.toString(),
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: isIndexActive(index)
                              ? theme.colorScheme.onSecondary
                              : theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: CustomScrollPage(
              controller: verticalController,
              builder: (controller) => ListView.builder(
                controller: controller,
                itemCount: 10,
                itemBuilder: (_, index) => AutoScrollTag(
                  key: ValueKey(index),
                  controller: verticalController,
                  index: index,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: VisibilityDetector(
                          key: ValueKey(index),
                          onVisibilityChanged: (visibilityInfo) {
                            if (visibilityInfo.visibleFraction == 1) {
                              setIndex(
                                newIndex: index,
                                shouldScrollVertically: false,
                              );
                            }
                          },
                          child: Text(
                            'Tutaj jest sekcja nr $index',
                            style: theme.textTheme.headlineSmall,
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          height: 1000,
                          child: Text(
                            'Tutaj będzie kontent sekcji nr ${index.toString()}',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
