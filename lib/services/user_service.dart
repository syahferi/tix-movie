part of "services.dart";

class UserService {
  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> updateData(UserTix userTix) async {
    userCollection.doc(userTix.id).set({
      'email': userTix.email,
      'name': userTix.name,
      'balance': userTix.accountBalance,
      'selectedGenre': userTix.selectedGenre,
      'selectedLanguage': userTix.selectedLanguage,
      'profilePicture': userTix.profilePicture ?? '',
    });
  }

  static Future<UserTix> getUser(String id) async {
    final userSnapshot = await userCollection.doc(id).get();
    if (userSnapshot.exists) {
      final data = userSnapshot.data() as Map<String, dynamic>;
      return UserTix(
        id: id,
        name: data['name'],
        email: data['email'],
        selectedLanguage: data['selectedLanguage'],
        selectedGenre: List<String>.from(data['selectedGenre']),
        accountBalance: data['balance'],
        profilePicture: data['profilePicture'],
      );
    } else {
      return UserTix(id: id);
    }
  }
}
