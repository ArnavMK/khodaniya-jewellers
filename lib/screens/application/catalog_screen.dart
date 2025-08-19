import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:khodaniya_jewellers/components/item_tile.dart';
import 'package:khodaniya_jewellers/constants/constants.dart';
import 'package:stock_repository/database/stock_database.dart';
import 'package:stock_repository/models/models.dart';
import 'package:user_repository/user_repository.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundColor.withValues(),
              ),
            ),
          ),
        ),
        title: Row(
          children: [
            Icon(Icons.diamond_outlined),
            const SizedBox(width: 5),
            const Text(
              "Catalogue", 
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.favorites);
            },
            icon: Icon(CupertinoIcons.square_favorites_alt),    
          ),
          IconButton(
            onPressed: () async {
              await UserRepository.instance.logOut();
              Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
            },
            icon: Icon(Icons.logout_outlined),
          )
        ],
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
            
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: spacing,
                mainAxisSpacing: 10,
                childAspectRatio: 9/16
              ),
              itemCount: LocalStockDatabase.instance.getAllStocks().length,
              itemBuilder: (context, int i) {
                Item item = LocalStockDatabase.instance.getAllStocks().elementAt(i);
                return ItemTile(item: item);
              },
            );
          },
        ),
      ),
    );
  }
}
