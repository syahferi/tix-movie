import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tix_movie/model/models.dart';
import 'package:tix_movie/services/services.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UserLoaded) {
      UserTix user = await UserService.getUser(event.id);
      yield UserLoadSuccess(user);
    } else if (event is UpdatedData) {
      UserTix updatedUser = (state as UserLoadSuccess).user.copyWith(
            name: event.name,
            profilePicture: event.profileImage,
          );
      await UserService.updateData(updatedUser);
      yield UserLoadSuccess(updatedUser);
    } else {
      yield UserSignOutSuccess();
    }
  }
}
