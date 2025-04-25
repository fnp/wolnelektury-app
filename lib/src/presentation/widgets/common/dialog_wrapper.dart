import 'package:flutter/material.dart';
import 'package:wolnelektury/src/presentation/widgets/common/custom_button.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class DialogWrapper extends StatefulWidget {
  const DialogWrapper({
    super.key,
    required this.child,
    required this.title,
    required this.icon,
  });

  final Widget child;
  final String title;
  final IconData icon;

  @override
  State<DialogWrapper> createState() => _DialogWrapperState();
}

class _DialogWrapperState extends State<DialogWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1700),
      vsync: this,
    )..repeat();

    _rotationAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: 0), weight: 1.5),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -0.1), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -0.1, end: 0.1), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.1, end: -0.1), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -0.1, end: 0.1), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.1, end: 0), weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInSine,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: Dimensions.mediumPadding,
        vertical: Dimensions.mediumPadding,
      ),
      contentPadding: const EdgeInsets.all(Dimensions.modalsPadding),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RotationTransition(
                turns: _rotationAnimation,
                child: Icon(
                  widget.icon,
                  color: theme.colorScheme.onSurface,
                  size: 24,
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: Dimensions.veryLargePadding,
                  ),
                  child: Text(
                    widget.title,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
              CustomButton(
                icon: Icons.close,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          const SizedBox(height: Dimensions.spacer),
          Flexible(child: widget.child),
        ],
      ),
    );
  }
}
