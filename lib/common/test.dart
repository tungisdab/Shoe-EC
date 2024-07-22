import 'package:app_shoes_ec/l10n/l10n.dart';
import 'package:app_shoes_ec/languages/bloc/localization_bloc.dart';
import 'package:app_shoes_ec/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Text(l10n!.setting),
          Text(l10n.name),
          Text(l10n.color),
          Text(l10n.language),
          ElevatedButton(
              onPressed: () {
                context
                    .read<LocalizationBloc>()
                    .add(const ChangeAppLocalization(
                      selectLanguage: Language.spanish,
                    ));
              },
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: const Text('Change Language'),
              ))
        ],
      )),
    );
  }
}
