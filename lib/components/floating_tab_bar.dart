import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khodaniya_jewellers/constants/constants.dart';

enum Tabs {
  home,
  profile,
  catalogue,
  search
}


class TabBarCreator {
  static Widget create({
    required BuildContext context,
    required Tabs currentTab,
  }) {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 16,
      child: SafeArea(
        minimum: const EdgeInsets.all(8),
        child: FloatingTabBar(
          currentTab: currentTab, 
          onTap: (tab) {
            switch (tab) {
              case Tabs.search:
                Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.search, (_) => false);
                break;
              case Tabs.profile:
                Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.profile, (_) => false);
                break;
              case Tabs.catalogue:
                Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.catalog, (_) => false);
                break;
              case Tabs.home:
                Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home, (_) => false);
                break;
            }
          },
        ),
      ),
    );
  }

  static Widget bottomPinned({
    required BuildContext context,
    required Tabs currentTab,
  }) {
    return SafeArea(
      minimum: const EdgeInsets.all(16),
      child: FloatingTabBar(
        currentTab: currentTab,
        onTap: (tab) {
          switch (tab) {
            case Tabs.search:
              Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.search, (_) => false);
              break;
            case Tabs.profile:
              Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.profile, (_) => false);
              break;
            case Tabs.catalogue:
              Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.catalog, (_) => false);
              break;
            case Tabs.home:
              Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home, (_) => false);
              break;
          }
        },
      ),
    );
  }
}

class FloatingTabBar extends StatelessWidget {
  final Tabs currentTab;
  final ValueChanged<Tabs>? onTap;

  const FloatingTabBar({super.key, required this.currentTab, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(30),
            blurRadius: 16,
            offset: const Offset(0, 8),
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _TabItem(
            icon: CupertinoIcons.house,
            label: 'Home',
            active: currentTab == Tabs.home,
            onTap: () => onTap?.call(Tabs.home),
          ),
          _TabItem(
            icon: CupertinoIcons.square_list,
            label: 'Catalogue',
            active: currentTab == Tabs.catalogue,
            onTap: () => onTap?.call(Tabs.catalogue),
          ),
          _TabItem(
            icon: CupertinoIcons.search,
            label: 'Search',
            active: currentTab == Tabs.search,
            onTap: () => onTap?.call(Tabs.search),
          ),
          _TabItem(
            icon: CupertinoIcons.person,
            label: 'Profile',
            active: currentTab == Tabs.profile,
            onTap: () => onTap?.call(Tabs.profile),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _TabItem({required this.icon, required this.label, required this.active, required this.onTap});

  @override
  State<_TabItem> createState() => _TabItemState();
}

class _TabItemState extends State<_TabItem> {
  @override
  Widget build(BuildContext context) {
    final Color color = widget.active ? Colors.black : Colors.grey;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(widget.icon, size: 20, color: color),
            const SizedBox(height: 2),
            Text(
              widget.label,
              style: TextStyle(fontSize: 10, color: color, fontWeight: widget.active ? FontWeight.w600 : FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}


