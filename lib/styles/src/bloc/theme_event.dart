part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class SetInitialTheme extends ThemeEvent{}
class ChangeTheme extends ThemeEvent{}
