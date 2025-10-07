import 'package:flutter/material.dart';
import 'package:wolnelektury/src/utils/ui/custom_colors.dart';
import 'package:wolnelektury/src/utils/ui/dimensions.dart';

class CustomDropdownElement<T> {
  const CustomDropdownElement({
    required this.title,
    required this.element,
    this.isSelected = false,
  });

  final String title;
  final T element;
  final bool isSelected;
}

class CustomDropdown<T> extends StatefulWidget {
  const CustomDropdown({
    super.key,
    required this.items,
    required this.onSelected,
    required this.icon,
    required this.label,
    required this.width,
    required this.highlightButton,
    this.maxElements,
  });

  final double width;
  final Widget icon;
  final String label;
  final List<CustomDropdownElement<T>> items;
  final Function(T element) onSelected;
  final bool highlightButton;
  final int? maxElements;

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>>
    with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isDropdownOpen = false;

  late AnimationController _animationController;
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _heightAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    final overlay = Overlay.of(context);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        final theme = Theme.of(context);

        const borderRadius = BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        );

        return Stack(
          children: [
            GestureDetector(
              onLongPress: _closeDropdown,
              onTap: _closeDropdown,
              onVerticalDragStart: (_) {
                _closeDropdown();
              },
              behavior: HitTestBehavior.translucent,
              child: Container(color: Colors.transparent),
            ),
            Positioned(
              width: widget.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                offset: const Offset(0, Dimensions.elementHeight),
                showWhenUnlinked: false,
                child: Material(
                  color: theme.colorScheme.surfaceContainer,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: SizeTransition(
                    sizeFactor: _heightAnimation,
                    axisAlignment: -1.0,
                    child: Ink(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainer,
                        borderRadius: borderRadius,
                      ),
                      child: SizedBox(
                        height: widget.maxElements != null
                            ? widget.maxElements! * Dimensions.elementHeight
                            : null,
                        child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          children: widget.items.map((item) {
                            return SizedBox(
                              height: Dimensions.elementHeight,
                              child: Ink(
                                color: item.isSelected
                                    ? CustomColors.primaryYellowColor
                                    : Colors.transparent,
                                child: InkWell(
                                  borderRadius: item == widget.items.last
                                      ? borderRadius
                                      : BorderRadius.zero,
                                  onTap: () {
                                    widget.onSelected(item.element);
                                    _closeDropdown();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: Dimensions.veryLargePadding,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item.title,
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: CustomColors.black,
                                                ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    overlay.insert(_overlayEntry!);
    _animationController.forward();
    setState(() {
      _isDropdownOpen = true;
    });
  }

  void _closeDropdown() {
    _animationController.reverse().then((_) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      setState(() {
        _isDropdownOpen = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(20),
      topRight: const Radius.circular(20),
      bottomLeft: _isDropdownOpen ? Radius.zero : const Radius.circular(20),
      bottomRight: _isDropdownOpen ? Radius.zero : const Radius.circular(20),
    );

    return CompositedTransformTarget(
      link: _layerLink,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: _toggleDropdown,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          curve: Curves.fastOutSlowIn,
          height: Dimensions.elementHeight,
          decoration: BoxDecoration(
            color: widget.highlightButton
                ? CustomColors.primaryYellowColor
                : theme.colorScheme.surfaceContainer,
            borderRadius: borderRadius,
          ),
          padding: const EdgeInsets.only(
            left: Dimensions.veryLargePadding,
            right: Dimensions.mediumPadding,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  widget.label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: CustomColors.black,
                  ),
                ),
              ),
              const Spacer(),
              widget.icon,
            ],
          ),
        ),
      ),
    );
  }
}
