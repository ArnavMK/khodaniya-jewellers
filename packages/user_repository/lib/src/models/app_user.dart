import '../constants/constants.dart';

class AppUser {
  
  /// the email which is the same as the email of the firebase auth user
  String email;

  /// the name which is unique to app user and is also saved in firestore
  String name;

  /// the user id which is the same as the firebaes auth user id.
  /// this is also the document ID for this user in the users collection
  /// in firestore
  String userId;

  AppUser({
    required this.email,
    required this.name,
    required this.userId,
  });  


  /// Factory constructor to create an AppUser instance from a Firestore document
  factory AppUser.fromDocument(Map<String, dynamic> data) {
    return AppUser(
      email: data['email'] ?? 'not-found',
      name: data['name'] ?? 'not-found',
      userId: data['userId'] ?? 'not-found',
    );
  }
  /// Converts the AppUser instance to a map for Firestore storage
  Map<String, dynamic> toDocument() {
    return {
      emailFieldText: email,
      userIdFieldText: userId,
      nameFieldText: name,
    };
  }
}
