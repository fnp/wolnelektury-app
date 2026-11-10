import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/features/catalogue/widgets/list_creation_mode_controls.dart';
import 'package:wolnelektury/src/features/common/cubits/app_mode/app_mode_cubit.dart';
import 'package:wolnelektury/src/features/my_library/widgets/quotes/my_library_quotes_section.dart';
import 'package:wolnelektury/src/features/readers/cubits/quotes/quotes_cubit.dart';

class QuoteListCreationPage extends StatelessWidget {
  const QuoteListCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return QuotesCubit(get.get())..getMyLibraryQuotes();
      },
      child: BlocBuilder<AppModeCubit, AppModeState>(
        buildWhen: (p, c) => p.mode != c.mode,
        builder: (context, state) {
          return Stack(
            children: [
              const MyLibraryQuotesSection(),
              if (state.isListQuotesCreation)
                const Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: ListCreationModeControls(),
                ),
            ],
          );
        },
      ),
    );
  }
}
