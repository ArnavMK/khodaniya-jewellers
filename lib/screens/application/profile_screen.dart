import 'package:flutter/material.dart';
import 'package:khodaniya_jewellers/components/components.dart';
import 'package:khodaniya_jewellers/constants/constants.dart';
import 'package:user_repository/user_repository.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppUser? user = UserRepository.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.person),
            const SizedBox(width: 8),
            const Text(
              "Profile",
              style: TextStyle(
                color: Colors.black,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Avatar placeholder (user image to be added later)
                Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey.shade200,
                    child: const Icon(Icons.person, size: 40, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    user?.name.isNotEmpty == true ? user!.name : 'Guest User',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Center(
                  child: Text(
                    user?.email.isNotEmpty == true ? user!.email : '-',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // User ID card
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(15),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.badge_outlined, color: Colors.black),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'User ID',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            Text(
                              (user?.userId.isNotEmpty == true) ? user!.userId : '-',
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Stats: Loyalty (placeholder) and Favorites count
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(15),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Loyalty Points', style: TextStyle(fontSize: 12, color: Colors.grey)),
                            SizedBox(height: 6),
                            // TODO: Replace with actual points when available
                            Text('—', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(15),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Favorites', style: TextStyle(fontSize: 12, color: Colors.grey)),
                            const SizedBox(height: 6),
                            Text(
                              user == null ? '0' : user.getFavoriteItemCount().toString(),
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Placeholder for more profile settings
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(15),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Profile Settings',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Image and additional fields coming soon...',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: TabBarCreator.bottomPinned(context: context, currentTab: Tabs.profile),
    );
  }
}
