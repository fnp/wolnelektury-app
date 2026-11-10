import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/generated/locale_keys.g.dart';
import 'package:wolnelektury/src/enums/success_enum.dart';
import 'package:wolnelektury/src/features/readers/cubits/quotes/quotes_cubit.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';

/// Shows a snackbar with the result of creating a quote.
class QuoteListener extends StatelessWidget {
  final Widget child;
  const QuoteListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuotesCubit, QuotesState>(
      listenWhen: (p, c) => p.isQuoteSuccess != c.isQuoteSuccess,
      listener: (context, state) {
        final result = state.isQuoteSuccess;
        if (result == null || result.$1 != Success.create) return;
        if (result.$2) {
          CustomSnackbar.success(
            context,
            LocaleKeys.reader_snackbar_quote_added_success.tr(),
          );
        } else {
          CustomSnackbar.error(
            context,
            LocaleKeys.reader_snackbar_quote_add_error.tr(),
          );
        }
      },
      child: child,
    );
  }
}
