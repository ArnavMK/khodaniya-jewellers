import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khodaniya_jewellers/components/components.dart';
import 'package:khodaniya_jewellers/constants/constants.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Row(
          children: [
            Icon(
              CupertinoIcons.search,
            ),
            const SizedBox(width: 8),
            Text(
              "Search",
              style: TextStyle(
                color: Colors.black,
                fontSize: 26,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        )
      ),
      body: const SizedBox.shrink(),
      bottomNavigationBar: TabBarCreator.bottomPinned(context: context, currentTab: Tabs.search),
    );
  }
}
