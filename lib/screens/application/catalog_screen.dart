import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:khodaniya_jewellers/components/item_tile.dart';
import 'package:khodaniya_jewellers/constants/constants.dart';
import 'package:stock_repository/database/stock_database.dart';
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
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 9/16
          ),
          itemCount: LocalStockDatabase.instance.getAllStocks().length,
          itemBuilder: (context, int i) {
            return ItemTile(index: i);
          },
        ),
      ),
    );
  }
}
