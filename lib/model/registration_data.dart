part of 'models.dart';

class RegistrationData {
  final String name;
  final String email;
  final String password;
  final List<String> selectedGenres;
  final String selectedLang;
  final File? profileImage;

  RegistrationData({
    this.name = '',
    this.email = '',
    this.password = '',
    this.selectedGenres = const [],
    this.selectedLang = '',
    this.profileImage,
  });
}
