part of 'services.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future signUp(String email, String password, String name,
      List<String> selectedGenres, String selectedLanguage) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      UserTix? userTix = userCredential.user?.convertToUser(
        name: name,
        selectedGenre: selectedGenres,
        selectedLanguage: selectedLanguage,
      );

      await UserService.updateData(userTix ?? UserTix(id: 'null'));
      return SignInSignUpResult(userTix: userTix);
    } catch (e) {
      return SignInSignUpResult(message: e.toString());
    }
  }

  static Future<SignInSignUpResult> signIn(
      String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = await result.user?.getUser();
      return SignInSignUpResult(userTix: user);
    } catch (e) {
      return SignInSignUpResult(message: e.toString());
    }
  }

  static Future signOut() async => await _auth.signOut();

  static Stream<User?> get userStream => _auth.authStateChanges();
}

class SignInSignUpResult {
  final UserTix? userTix;
  final String? message;

  SignInSignUpResult({this.userTix, this.message});
}
