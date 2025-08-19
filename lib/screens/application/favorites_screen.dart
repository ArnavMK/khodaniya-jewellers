import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khodaniya_jewellers/components/item_tile.dart';
import 'package:khodaniya_jewellers/constants/constants.dart';
import 'package:stock_repository/models/models.dart';
import 'package:user_repository/user_repository.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  final AppUser? currentUser = UserRepository.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Favorites", 
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          )
        ),
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {

            // Calculate number of columns based on screen width
            // Desired tile width: 200px (160px image + 40px padding/margins)
            // Add spacing between tiles
            double desiredTileWidth = 200.0;
            double spacing = 10.0;
            int crossAxisCount = ((constraints.maxWidth - (2 * 16.0)) / (desiredTileWidth + spacing)).floor();
            
            // Ensure at least 2 columns and at most 4 columns
            crossAxisCount = crossAxisCount.clamp(2, 4);

            if (_getCount() == 0) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.heart_slash_circle,
                      size: 50,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "No favorites yet",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey
                      )
                    )
                  ],
                ), 
              );
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: spacing,
                mainAxisSpacing: 10,
                childAspectRatio: 9/16
              ),
              itemCount: _getCount(),
              itemBuilder: (context, int i) {
                Item? item = _getItem(i);
                if (item == null) {
                  return null;
                }
                return ItemTile(item: item);
              },
            );
          },
        ),
      ),
    );
  }

  int _getCount() {
    if (currentUser == null) {
      return 0;
    }
    return currentUser!.getFavoriteItemCount();
  }

  Item? _getItem(int index) {
    if (currentUser == null) {
      return null;
    }
    return currentUser!.getFavoriteItemWithIndex(index);
  }
}

