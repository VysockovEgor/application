class OnboardingData {
  final String imagePath;
  final String title;
  final String description;

  const OnboardingData({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

final List<OnboardingData> onboardingData = [
  const OnboardingData(
    imagePath: 'assets/images/onboarding1.png',
    title: 'Добро пожаловать в TeenBank!',
    description: 'Твой первый шаг к финансовой независимости. Учись управлять деньгами с умом!',
  ),
  const OnboardingData(
    imagePath: 'assets/images/onboarding2.png',
    title: 'Отслеживай свои расходы',
    description: 'Анализируй свои траты, ставь цели и экономь с помощью умных инструментов.',
  ),
  const OnboardingData(
    imagePath: 'assets/images/onboarding3.png',
    title: 'Зарабатывай баллы',
    description: 'Выполняй задания, учись финансовой грамотности и получай награды за свои достижения!',
  ),
  const OnboardingData(
    imagePath: 'assets/images/onboarding4.png',
    title: 'Безопасность превыше всего',
    description: 'Твои деньги и данные под надежной защитой. Родители всегда в курсе твоих финансов.',
  ),
];
