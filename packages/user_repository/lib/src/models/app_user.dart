import 'package:stock_repository/models/models.dart';

import '../constants/constants.dart';

/// the custom model to represent a user
class AppUser {
  
  /// the email which is the same as the email of the firebase auth user
  String email;

  /// the name which is unique to app user and is also saved in firestore
  String name;

  /// the user id which is the same as the firebaes auth user id.
  /// this is also the document ID for this user in the users collection
  /// in firestore
  String userId;


  /// This is are all the items that the user likes and selected for the visit
  /// to the store.
  final List<Item> _favorites = [];

  AppUser({
    required this.email,
    required this.name,
    required this.userId,
  });  

  void addItemToFavorites(Item item) {
    // avoid duplicates by id
    _favorites.add(item);
  }
  
  int getFavoriteItemCount() {
    return  _favorites.length;
  }

  void removeItemFromFavorites(Item item) {
    _favorites.remove(item);
  }

  Item getFavoriteItemWithIndex(int index) {
    return _favorites[index];
  }

  bool isFavorite(Item item) {
    return _favorites.any((i) => i.id == item.id);
  }
  
  static AppUser empty = AppUser(userId: "", name: "", email: "");

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
