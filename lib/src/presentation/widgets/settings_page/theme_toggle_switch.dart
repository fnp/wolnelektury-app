import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/presentation/cubits/settings/settings_cubit.dart';
import 'package:wolnelektury/src/presentation/enums/app_theme_enum.dart';
import 'package:wolnelektury/src/utils/ui/custom_icons.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class ThemeToggleSwitch extends StatefulWidget {
  const ThemeToggleSwitch({
    super.key,
    required this.initialMode,
  });

  final AppTheme initialMode;

  @override
  State<ThemeToggleSwitch> createState() => _ThemeToggleSwitchState();
}

class _ThemeToggleSwitchState extends State<ThemeToggleSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _offsetAnimation;

  final List<AppTheme> _modes = [
    AppTheme.light,
    AppTheme.adaptive,
    AppTheme.dark,
  ];

  int _indexForMode(AppTheme mode) => _modes.indexOf(mode);
  int _currentState = 0;

  @override
  void initState() {
    super.initState();
    _setCurrentState(mode: widget.initialMode);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _offsetAnimation = Tween<double>(begin: -40, end: 40).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _setCurrentState({AppTheme? mode}) {
    setState(() {
      if (mode == null) {
        if (_currentState == 2) {
          _currentState = 0;
        } else {
          _currentState++;
        }
      } else {
        _currentState = _indexForMode(mode);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animateToNextState();
    });
  }

  void _animateToNextState() {
    final double begin = _offsetAnimation.value;
    final double end = _currentState == 0
        ? -40
        : _currentState == 1
            ? 0
            : 40;

    _offsetAnimation = Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller
      ..reset()
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Text(
          _determineText,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontFeatures: [const FontFeature.enable('smcp')],
          ),
        ),
        const SizedBox(
          width: Dimensions.veryLargePadding,
        ),
        GestureDetector(
          onTap: () {
            _setCurrentState();
            BlocProvider.of<SettingsCubit>(context).setTheme(
              _modes[_currentState],
            );
          },
          child: SizedBox(
            width: Dimensions.elementHeight * 3,
            height: Dimensions.elementHeight,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  Dimensions.elementHeight / 2,
                ),
                color: theme.colorScheme.onSecondaryContainer,
              ),
              child: AnimatedBuilder(
                animation: _offsetAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(_offsetAnimation.value, 0),
                    child: Align(
                      alignment: Alignment.center,
                      child: child,
                    ),
                  );
                },
                child: SizedBox.square(
                  dimension: Dimensions.elementHeight - 10,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        Dimensions.elementHeight / 2,
                      ),
                      color: theme.colorScheme.secondaryContainer,
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      child: _determineChild,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String get _determineText {
    final mode = _modes[_currentState];
    switch (mode) {
      case AppTheme.light:
        return LocaleKeys.settings_set_theme_off.tr();
      case AppTheme.adaptive:
        return LocaleKeys.settings_set_theme_auto.tr();
      case AppTheme.dark:
        return LocaleKeys.settings_set_theme_on.tr();
    }
  }

  Widget get _determineChild {
    final mode = _modes[_currentState];
    switch (mode) {
      case AppTheme.light:
        return const Icon(
          key: ValueKey(AppTheme.light),
          CustomIcons.night_sight_auto_off,
          size: 20,
        );
      case AppTheme.adaptive:
        return const Icon(
          key: ValueKey(AppTheme.adaptive),
          CustomIcons.night_sight_auto,
          size: 20,
        );
      case AppTheme.dark:
        return const Icon(
          key: ValueKey(AppTheme.dark),
          CustomIcons.dark_mode,
          size: 20,
        );
    }
  }
}
