part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserLoaded extends UserEvent {
  final String id;

  UserLoaded(this.id);

  @override
  List<Object> get props => [id];
}

class UserSignOut extends UserEvent {
  @override
  List<Object> get props => [];
}

class UpdatedData extends UserEvent {
  final String? name;
  final String? profileImage;

  UpdatedData({this.name, this.profileImage});

  @override
  List<Object> get props => [];
}
