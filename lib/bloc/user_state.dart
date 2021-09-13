part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoadSuccess extends UserState {
  final UserTix user;

  UserLoadSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class UserSignOutSuccess extends UserState {
  @override
  List<Object> get props => [];
}
