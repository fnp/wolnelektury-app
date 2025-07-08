import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:wolnelektury/src/config/getter.dart';
import 'package:wolnelektury/src/config/initializers/repository_initializer.dart';
import 'package:wolnelektury/src/config/initializers/service_initializer.dart';
import 'package:wolnelektury/src/config/router/router.dart';
import 'package:wolnelektury/src/config/theme/theme.dart';
import 'package:wolnelektury/src/presentation/cubits/app_mode/app_mode_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/connectivity/connectivity_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/settings/settings_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/synchronizer/synchronizer_cubit.dart';
import 'package:wolnelektury/src/presentation/enums/app_theme_enum.dart';
import 'package:wolnelektury/src/utils/ui/custom_snackbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await EasyLocalization.ensureInitialized();
  await initializeServices(getIt: get);
  await initializeRepositories(getIt: get);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await JustAudioBackground.init(
    androidNotificationChannelId: 'pl.app.wolnelektury.audiobook.channel.audio',
    androidNotificationChannelName: 'Audiobook Playback',
    androidNotificationOngoing: true,
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('pl', 'PL')],
      path: 'assets/translations',
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(lazy: false, create: (context) => ConnectivityCubit()),
        BlocProvider(
          lazy: false,
          create: (context) => SettingsCubit(get.get()),
        ),
        BlocProvider(create: (context) => AppModeCubit()),
        BlocProvider(create: (context) => SynchronizerCubit(get.get())),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        buildWhen: (p, c) => p.theme != c.theme,
        builder: (context, state) {
          return MaterialApp.router(
            scaffoldMessengerKey: CustomSnackbar.scaffoldMessengerKey,
            debugShowCheckedModeBanner: false,
            title: 'Wolne Lektury',
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: _determineLightTheme(state.theme),
            darkTheme: _determineDarkTheme(state.theme),
            // Router configuration object
            routerConfig: router,
          );
        },
      ),
    );
  }

  ThemeData _determineLightTheme(AppTheme theme) {
    switch (theme) {
      case AppTheme.light:
        return lightTheme;
      case AppTheme.dark:
        return darkTheme;
      case AppTheme.adaptive:
        return lightTheme;
    }
  }

  ThemeData _determineDarkTheme(AppTheme theme) {
    switch (theme) {
      case AppTheme.light:
        return lightTheme;
      case AppTheme.dark:
        return darkTheme;
      case AppTheme.adaptive:
        return darkTheme;
    }
  }
}
