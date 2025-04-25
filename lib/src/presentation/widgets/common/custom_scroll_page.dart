import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wolnelektury/src/presentation/cubits/scroll/scroll_cubit.dart';

class CustomScrollPage extends HookWidget {
  final Widget Function(ScrollController scrollController) builder;
  final void Function()? onLoadMore;
  final ScrollController? controller;

  final double loadPoint;

  const CustomScrollPage({
    required this.builder,
    this.controller,
    this.onLoadMore,
    this.loadPoint = .1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scrollCubit = BlocProvider.of<ScrollCubit>(context);
    final scrollController = useScrollController();
    final maxScrollOffsetValue = useState<double?>(null);

    useEffect(
      () {
        void listener() {
          _scrollListener(
            controller ?? scrollController,
            maxScrollOffsetValue,
            scrollCubit,
          );
        }

        (controller ?? scrollController).addListener(listener);
        return () {
          (controller ?? scrollController).removeListener(listener);
        };
      },
      [controller ?? scrollController],
    );

    /// Handles case when list is larger than incoming childs
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!(controller ?? scrollController).hasClients) return;
      final position = (controller ?? scrollController).position;

      if (position.maxScrollExtent == 0 ||
          position.maxScrollExtent - position.pixels < 100) {
        onLoadMore?.call();
      }
    });

    return builder(controller ?? scrollController);
  }

  void _scrollListener(
    ScrollController scroll,
    ValueNotifier<double?> maxScrollOffsetValue,
    ScrollCubit scrollCubit,
  ) {
    final scrollOffset = scroll.offset;
    final maxOffset = scroll.position.maxScrollExtent;

    if (scroll.position.userScrollDirection == ScrollDirection.reverse) {
      scrollCubit.hideAppBar();
    } else {
      scrollCubit.showAppBar();
    }

    if (onLoadMore == null) return;
    if ((maxScrollOffsetValue.value == null ||
            maxScrollOffsetValue.value! < maxOffset) &&
        scrollOffset > (maxOffset * (1 - loadPoint))) {
      maxScrollOffsetValue.value = maxOffset;
      onLoadMore?.call();
    }
  }
}
