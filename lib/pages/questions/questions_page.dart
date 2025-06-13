import 'package:flutter/material.dart';
import '../../design/colors.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              height: 160,
              width: double.infinity,
              color: darkBlue,
              child: const Center(
                child: Text(
                  "Финансовая грамотность",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Tabs
            TabBar(
              controller: _tabController,
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(color: yellow, width: 3.0),
              ),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: 'Курсы'),
                Tab(text: 'Тесты'),
              ],
            ),
            // Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildCoursesTab(),
                  _buildTestsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoursesTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildCourseCard(
          'Основы финансовой грамотности',
          'Научись управлять своими деньгами с умом',
          Icons.account_balance,
          'Начальный',
          '4.8',
        ),
        _buildCourseCard(
          'Инвестиции для начинающих',
          'Познакомься с миром инвестиций',
          Icons.trending_up,
          'Средний',
          '4.6',
        ),
        _buildCourseCard(
          'Бюджетирование',
          'Учись планировать свои расходы',
          Icons.calendar_today,
          'Начальный',
          '4.9',
        ),
      ],
    );
  }

  Widget _buildTestsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildTestCard(
          'Проверь свои знания',
          'Тест по основам финансовой грамотности',
          Icons.quiz,
          '10 вопросов',
        ),
        _buildTestCard(
          'Инвестиционный тест',
          'Проверь свои знания об инвестициях',
          Icons.analytics,
          '15 вопросов',
        ),
        _buildTestCard(
          'Бюджетный тест',
          'Тест по планированию бюджета',
          Icons.account_balance_wallet,
          '12 вопросов',
        ),
      ],
    );
  }

  Widget _buildCourseCard(String title, String description, IconData icon, String level, String rating) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 32, color: darkBlue),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: yellow,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    level,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: yellow, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      rating,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestCard(String title, String description, IconData icon, String questions) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 32, color: darkBlue),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: yellow,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                questions,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
