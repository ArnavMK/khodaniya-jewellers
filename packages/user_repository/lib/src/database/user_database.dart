import "package:firebase_auth/firebase_auth.dart";
import "dart:developer" as dev show log;
import "package:user_repository/src/models/models.dart";

class UserRepository {

  UserRepository._privateConstructor();
  static final UserRepository _instance = UserRepository._privateConstructor();

  /// singleton for UserRepository
  static UserRepository get instance {
    return _instance;
  }

  /// creats user with firebase auth and in firestore through go backend
  Future<AppUser> createUser ({
    required String email,
    required String password,
    required String name
  }) async {

    try {
      final userCred = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      dev.log("User created with email: ${userCred.user?.email}", name: "UserRepository.createUser");
      // TODO: Save user in firestore through go backend
      return AppUser(
        email: userCred.user?.email ?? 'not-found',
        name: name,
        userId: userCred.user?.uid ?? 'not-found',
      );
    } 
    catch (e) {
      dev.log("Error creating user: $e", name: "UserRepository.createUser");
      rethrow; 
    }
  }

  /// log in with firebase auth through client
  Future<AppUser> loginUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final userCred = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      dev.log("User logged in with email: ${userCred.user?.email}", name: "UserRepository.loginUser");
      return AppUser(
        email: userCred.user?.email ?? 'not-found',
        name: name, 
        userId: userCred.user?.uid ?? 'not-found',
      );
    } 
    catch (e) {
      dev.log("Error logging in user: $e", name: "UserRepository.loginUser");
      rethrow; 
    }
  }  

  /// log out with firebase auth through client
  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      dev.log("User logged out", name: "UserRepository.logoutUser");
    } 
    catch (e) {
      dev.log("Error logging out user: $e", name: "UserRepository.logoutUser");
      rethrow; 
    }
  }
}

