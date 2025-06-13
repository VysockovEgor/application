import 'package:flutter/material.dart';
import '../../design/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/user_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              height: 160,
              width: double.infinity,
              color: darkBlue,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Text(
                        user.name[0].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: darkBlue,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      user.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Уровень ${user.level}',
                      style: const TextStyle(
                        color: yellow,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Content
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _buildSection(
                    'Финансы',
                    [
                      _buildMenuItem(
                        'Мой баланс',
                        Icons.account_balance_wallet,
                        () {},
                      ),
                      _buildMenuItem(
                        'История операций',
                        Icons.history,
                        () {},
                      ),
                      _buildMenuItem(
                        'Мои цели',
                        Icons.flag,
                        () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildSection(
                    'Обучение',
                    [
                      _buildMenuItem(
                        'Курсы',
                        Icons.school,
                        () {},
                      ),
                      _buildMenuItem(
                        'Достижения',
                        Icons.emoji_events,
                        () {},
                      ),
                      _buildMenuItem(
                        'Награды',
                        Icons.card_giftcard,
                        () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildSection(
                    'Настройки',
                    [
                      _buildMenuItem(
                        'Безопасность',
                        Icons.security,
                        () {},
                      ),
                      _buildMenuItem(
                        'Уведомления',
                        Icons.notifications,
                        () {},
                      ),
                      _buildMenuItem(
                        'Родительский контроль',
                        Icons.family_restroom,
                        () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: darkBlue,
          ),
        ),
        const SizedBox(height: 10),
        ...items,
      ],
    );
  }

  Widget _buildMenuItem(String title, IconData icon, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: darkBlue),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
