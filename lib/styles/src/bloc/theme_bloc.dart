import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, bool> {
  ThemeBloc() : super(true) {
    on<SetInitialTheme>((event, emit) async {
      bool hasThemeDark = await isDark();
      emit(hasThemeDark);
    });

    on<ChangeTheme>((event, emit) async {
      bool hasThemeDark = await isDark();
      bool newTheme = !hasThemeDark;
      emit(newTheme);
      setTheme(newTheme); 
    });
  }
}

Future<bool> isDark() async {
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getBool('isDark') ?? false;
}

Future<void> setTheme(bool isDark) async {
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setBool('isDark', isDark);
}
