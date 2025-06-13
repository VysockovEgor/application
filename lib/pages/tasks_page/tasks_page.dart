import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../design/colors.dart';
import '../../design/dimensions.dart';
import '../../design/images.dart';
import '../../providers/tasks_provider.dart';
import '../../providers/tasks_tab_provider.dart';
import 'level_tasks_page.dart';

const double normal = 16.0;

class TaskLevel {
  final String name;
  final int completedTasks;
  final int totalTasks;
  final Image levelImage;
  final bool isLocked;

  TaskLevel({
    required this.name,
    required this.completedTasks,
    required this.totalTasks,
    required this.levelImage,
    this.isLocked = false,
  });
}

class TasksPage extends ConsumerStatefulWidget {
  const TasksPage({super.key});

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends ConsumerState<TasksPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(tasksProvider);
    final tabIndex = ref.watch(tasksTabIndexProvider);
    final screenWidth = MediaQuery.of(context).size.width;

    // Подсчитываем выполненные задачи для каждого уровня
    final completedByLevel = [0, 0, 0];
    final totalByLevel = [0, 0, 0];

    for (var task in tasks) {
      totalByLevel[task.level]++;
      if (task.isSolved) {
        completedByLevel[task.level]++;
      }
    }

    // Проверяем доступность уровней
    final isLevel1Complete =
        totalByLevel[0] > 0 && completedByLevel[0] == totalByLevel[0];
    final isLevel2Complete =
        totalByLevel[1] > 0 && completedByLevel[1] == totalByLevel[1];

    // Обновляем список уровней с реальными данными и статусом блокировки
    final levels = [
      TaskLevel(
        name: 'Новичок',
        completedTasks: completedByLevel[0],
        totalTasks: totalByLevel[0],
        levelImage: beginner_level,
        isLocked: false, // Первый уровень всегда доступен
      ),
      TaskLevel(
        name: 'Продвинутый',
        completedTasks: completedByLevel[1],
        totalTasks: totalByLevel[1],
        levelImage: advanced_level,
        isLocked:
            !isLevel1Complete, // Заблокирован, пока не пройден первый уровень
      ),
      TaskLevel(
        name: 'Профи',
        completedTasks: completedByLevel[2],
        totalTasks: totalByLevel[2],
        levelImage: pro_level,
        isLocked:
            !isLevel2Complete, // Заблокирован, пока не пройден второй уровень
      ),
    ];

    // Синхронизируем контроллер с провайдером
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_tabController.index != tabIndex) {
        _tabController.animateTo(tabIndex);
      }
    });

    final filteredTasks = tasks.where((task) {
      final title = _getTaskTitle(task.details).toLowerCase();
      return title.contains(_searchQuery.toLowerCase());
    }).toList();

    final unsolvedTasks =
        filteredTasks.where((task) => !task.isSolved).toList();
    final solvedTasks = filteredTasks.where((task) => task.isSolved).toList();

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
                  "Финансовая аналитика",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Content
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildBalanceCard(),
                  const SizedBox(height: 16),
                  _buildExpensesCard(),
                  const SizedBox(height: 16),
                  _buildGoalsCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Твой баланс",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: darkBlue,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "₽ 5,000",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Доступно",
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: yellow,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.add, size: 20),
                      SizedBox(width: 4),
                      Text(
                        "Пополнить",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpensesCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Расходы за месяц",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: darkBlue,
              ),
            ),
            const SizedBox(height: 16),
            _buildExpenseItem("Еда", "₽ 2,500", 0.5),
            _buildExpenseItem("Развлечения", "₽ 1,200", 0.3),
            _buildExpenseItem("Транспорт", "₽ 800", 0.2),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseItem(String category, String amount, double percentage) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                amount,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: percentage,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(yellow),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Твои цели",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: darkBlue,
              ),
            ),
            const SizedBox(height: 16),
            _buildGoalItem(
              "Новый телефон",
              "₽ 30,000",
              "₽ 15,000",
              Icons.phone_android,
            ),
            _buildGoalItem(
              "Велосипед",
              "₽ 20,000",
              "₽ 8,000",
              Icons.directions_bike,
            ),
            _buildGoalItem(
              "Подарок маме",
              "₽ 5,000",
              "₽ 3,000",
              Icons.card_giftcard,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalItem(String title, String target, String current, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: darkBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: darkBlue),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "$current из $target",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: yellow,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "50%",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getTaskTitle(List<Map<String, String>> details) {
    for (var item in details) {
      if (item.containsKey("title")) {
        return item["title"]!;
      }
    }
    return "";
  }
}
