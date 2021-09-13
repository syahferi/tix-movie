part of 'models.dart';

class UserTix extends Equatable {
  final String? id;
  final String? name;
  final String? email;
  final List<String>? selectedGenre;
  final String? selectedLanguage;
  final String? profilePicture;
  final int? accountBalance;

  UserTix({
    required this.id,
    this.email,
    this.name = "no name",
    this.selectedGenre = const [],
    this.selectedLanguage = "english",
    this.profilePicture = "",
    this.accountBalance = 10000,
  });

  @override
  List<Object?> get props => [id];
}
