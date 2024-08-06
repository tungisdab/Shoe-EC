import 'package:app_shoes_ec/components/components.dart';
import 'package:app_shoes_ec/l10n/l10n.dart';
import 'package:app_shoes_ec/languages/bloc/localization_bloc.dart';
import 'package:app_shoes_ec/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class SettingsApp extends StatefulWidget {
  const SettingsApp({super.key});

  @override
  State<SettingsApp> createState() => _SettingsAppState();
}

class _SettingsAppState extends State<SettingsApp> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('SettingsApp'),
        leading: IconButton(
          icon:  const Icon(IconlyBroken.arrow_left_square, ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          BlocBuilder<ThemeBloc, bool>(
            builder: (context, state) {
              return Switch(
                value: state,
                onChanged: (bool val) {
                  context.read<ThemeBloc>().add(ChangeTheme());
                },
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Text(l10n!.setting),
            // Text(l10n.name),
            // Text(l10n.color),
            // Text(l10n.language),
            BlocBuilder<ThemeBloc, bool>(
              builder: (context, state) {
                return Text('Current Theme: ${state ? 'Dark' : 'Light'}');
              },
            ),
            ElevatedButton(
              onPressed: () {
                ChangeLanguageBottomSheet.showLanguageBottomSheet(context);
              },
              child: const Text('Change Language'),
            ),
            BlocBuilder<LocalizationBloc, LocalizationState>(
              builder: (context, state) {
                return Text(
                  'Selected Language: ${state.selectedLanguage.text}',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
