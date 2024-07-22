import 'package:app_shoes_ec/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'localization_event.dart';
part 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc() : super(const LocalizationState()) {
    on<ChangeAppLocalization>(onChangeLanguage);
    on<GetLanguage>(onGetLanguage);
  }

  onChangeLanguage(
      ChangeAppLocalization event, Emitter<LocalizationState> emit) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(
      'localLanguage',
      event.selectLanguage.locale.languageCode,
    );
    emit(state.copyWith(selectedLanguage: event.selectLanguage));
  }

  onGetLanguage(GetLanguage event, Emitter<LocalizationState> emit) async {
    final pref = await SharedPreferences.getInstance();
    final localLanguage = pref.getString('localLanguage');
    emit(
      state.copyWith(
        selectedLanguage: localLanguage != null
            ? Language.values
                .where((language) =>
                    language.locale.languageCode == localLanguage)
                .first
            : Language.vietnamese,
      ),
    );
  }
}
