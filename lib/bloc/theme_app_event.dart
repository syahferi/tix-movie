part of 'theme_app_bloc.dart';

@immutable
abstract class ThemeAppEvent extends Equatable {}

class ThemeAppChanged extends ThemeAppEvent {
  final ThemeData themeData;

  ThemeAppChanged(this.themeData);

  @override
  List<Object> get props => [themeData];
}
