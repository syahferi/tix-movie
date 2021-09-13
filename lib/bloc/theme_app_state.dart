part of 'theme_app_bloc.dart';

@immutable
class ThemeAppState extends Equatable {
  final ThemeData themeData;

  const ThemeAppState(this.themeData);

  @override
  List<Object> get props => [themeData];
}
