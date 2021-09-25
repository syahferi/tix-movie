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
    this.name = "",
    this.selectedGenre = const [],
    this.selectedLanguage = "english",
    this.profilePicture = "",
    this.accountBalance = 0,
  });

  UserTix copyWith({String? name, String? profilePicture, int? balance}) =>
      UserTix(
        id: this.id,
        email: this.email,
        name: name ?? this.name,
        selectedGenre: this.selectedGenre,
        selectedLanguage: this.selectedLanguage,
        profilePicture: profilePicture ?? this.profilePicture,
        accountBalance: balance ?? this.accountBalance,
      );

  @override
  List<Object?> get props => [id];
}
