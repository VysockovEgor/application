import 'package:flutter_riverpod/flutter_riverpod.dart';

class User {
  final String name;
  final int level;
  final int points;
  final double balance;
  final List<Map<String, dynamic>> goals;
  final List<Map<String, dynamic>> achievements;

  const User({
    required this.name,
    required this.level,
    required this.points,
    required this.balance,
    required this.goals,
    required this.achievements,
  });
}

final userProvider = Provider<User>((ref) {
  return const User(
    name: 'Алексей',
    level: 3,
    points: 750,
    balance: 5000.0,
    goals: [
      {
        'title': 'Новый телефон',
        'target': 30000.0,
        'current': 15000.0,
        'icon': 'phone_android',
      },
      {
        'title': 'Велосипед',
        'target': 20000.0,
        'current': 8000.0,
        'icon': 'directions_bike',
      },
      {
        'title': 'Подарок маме',
        'target': 5000.0,
        'current': 3000.0,
        'icon': 'card_giftcard',
      },
    ],
    achievements: [
      {
        'title': 'Первая экономия',
        'description': 'Накопил первую 1000 рублей',
        'icon': 'savings',
        'completed': true,
      },
      {
        'title': 'Финансовый гений',
        'description': 'Прошел все курсы по финансовой грамотности',
        'icon': 'school',
        'completed': false,
      },
      {
        'title': 'Целеустремленный',
        'description': 'Достиг своей первой финансовой цели',
        'icon': 'flag',
        'completed': true,
      },
    ],
  );
});
