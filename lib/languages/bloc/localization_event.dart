part of 'localization_bloc.dart';

sealed class LocalizationEvent extends Equatable {
  const LocalizationEvent();

  @override
  List<Object> get props => [];
}

class ChangeAppLocalization extends LocalizationEvent {
  final Language selectLanguage;

  const ChangeAppLocalization({required this.selectLanguage});

  @override
  List<Object> get props => [selectLanguage];
  
}

class GetLanguage extends LocalizationEvent {
  
}
