import 'package:flutter/material.dart';
import '../models/lesson.dart';
import 'card1.dart';

class TopicGridView extends StatelessWidget {
  final List<Lesson> lessons;
  // УДАЛЕНО: final PlanManager planManager;

  const TopicGridView({
    super.key,
    required this.lessons,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: lessons.length,
      itemBuilder: (context, index) {
        return Card1(
          lesson: lessons[index],
        );
      },
    );
  }
}