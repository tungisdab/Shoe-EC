import 'package:app_shoes_ec/authentication/authentication.dart';
import 'package:app_shoes_ec/languages/languages.dart';
import 'package:app_shoes_ec/styles/style.dart';
import 'package:app_shoes_ec/l10n/l10n.dart';
import 'package:app_shoes_ec/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:user_repository/user_repository.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  const MyApp({required this.userRepository, super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle());

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthenticationBloc>(
              create: (context) => AuthenticationBloc(userRepository: userRepository),
            ),
            BlocProvider<ThemeBloc>(
              create: (context) => ThemeBloc()..add(SetInitialTheme()),
            ),
            BlocProvider<LocalizationBloc>(
              create: (context) => LocalizationBloc()..add(GetLanguage()),
            ),
            BlocProvider<BottomNavCubit>(
              create: (context) => BottomNavCubit(),
            ),
          ],
          child: const MyAppView(),
        );
      },
    );
  }
}

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, bool>(
      builder: (context, themeState) {
        return BlocBuilder<LocalizationBloc, LocalizationState>(
          buildWhen: (previous, current) => previous.selectedLanguage != current.selectedLanguage,
          builder: (context, localizationState) {
            return BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, authState) {
                if (authState.status == AuthenticationStatus.authenticated) {
                  return MaterialApp(
                    title: 'App Shoes E-commerce',
                    debugShowCheckedModeBanner: false,
                    theme: themeState
                        ? AppTheme(AppColors.dark).getTheme()
                        : AppTheme(AppColors.light).getTheme(),
                    locale: localizationState.selectedLanguage.locale,
                    supportedLocales: AppLocalizations.supportedLocales,
                    localizationsDelegates: AppLocalizations.localizationsDelegates,
                    home: BlocProvider(
                      create: (context) => SignInBloc(
                        userRepository: context.read<AuthenticationBloc>().userRepository,
                      ),
                      child: const BottomMenu(),
                    ),
                  );
                } else {
                  return MaterialApp(
                    title: 'App Shoes E-commerce',
                    debugShowCheckedModeBanner: false,
                    theme: themeState
                        ? AppTheme(AppColors.dark).getTheme()
                        : AppTheme(AppColors.light).getTheme(),
                    locale: localizationState.selectedLanguage.locale,
                    supportedLocales: AppLocalizations.supportedLocales,
                    localizationsDelegates: AppLocalizations.localizationsDelegates,
                    home: const WelcomeScreen(),
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}
