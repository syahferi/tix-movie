part of 'extensions.dart';

extension FirebaseUserExtension on User {
  UserTix convertToUser({
    String? name,
    List<String>? selectedGenre,
    String? selectedLanguage,
    int? balance,
  }) =>
      UserTix(
        id: this.uid,
        email: this.email,
        name: name,
        selectedGenre: selectedGenre,
        selectedLanguage: selectedLanguage,
        accountBalance: balance,
      );

  Future<UserTix> getUser() async => await UserService.getUser(this.uid);
}
