import 'package:app_shoes_ec/languages/bloc/localization_bloc.dart';
import 'package:app_shoes_ec/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangeLanguageBottomSheet {
  static void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            children: [
              const SizedBox(
                height: 100,
                // color: Colors.red,
                child: Text('Change Language'),
              ),
              BlocBuilder<LocalizationBloc, LocalizationState>(
                buildWhen: (previous, current) =>
                    previous.selectedLanguage != current.selectedLanguage,
                builder: (context, state) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          context.read<LocalizationBloc>().add(
                                ChangeAppLocalization(
                                  selectLanguage: Language.values[index],
                                ),
                              );
                          Future.delayed(const Duration(milliseconds: 300))
                              .then((value) => Navigator.of(context).pop());
                        },
                        leading: ClipOval(
                          child: Language.values[index].image.image(
                            height: 32.0,
                            width: 32.0,
                          ),
                        ),
                        title: Text(Language.values[index].text),
                        trailing: Language.values[index] == state.selectedLanguage
                            ? const Icon(
                                Icons.check_circle_rounded,
                                color: Colors.red,
                              )
                            : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: Language.values[index] == state.selectedLanguage
                              ? const BorderSide(color: Colors.red, width: 1.5)
                              : BorderSide(color: Colors.grey[300]!),
                        ),
                        tileColor:
                            Language.values[index] == state.selectedLanguage
                                ? Colors.red
                                : null,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 15.h,
                      );
                    },
                    itemCount: Language.values.length,
                  );
                },
              )
            ],
          );
        });
  }
}
