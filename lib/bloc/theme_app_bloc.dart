import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'theme_app_event.dart';
part 'theme_app_state.dart';

class ThemeAppBloc extends Bloc<ThemeAppEvent, ThemeAppState> {
  ThemeAppBloc() : super(ThemeAppState(ThemeData()));

  @override
  Stream<ThemeAppState> mapEventToState(
    ThemeAppEvent event,
  ) async* {
    if (event is ThemeAppChanged) {
      yield ThemeAppState(event.themeData);
    }
  }
}
