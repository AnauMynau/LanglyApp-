import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/lesson.dart';
import '../models/plan_item.dart';
import '../providers.dart'; // Обязательно импортируем файл с нашими провайдерами

// 1. Меняем на ConsumerStatefulWidget
class ExerciseScreen extends ConsumerStatefulWidget {
  final Exercise exercise;

  const ExerciseScreen({
    super.key,
    required this.exercise,
  });

  @override
  ConsumerState<ExerciseScreen> createState() => _ExerciseScreenState();
}

// 2. Меняем State на ConsumerState
class _ExerciseScreenState extends ConsumerState<ExerciseScreen> {
  int _intensity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: 40,
              height: 4,
              color: Colors.grey[300],
              margin: const EdgeInsets.only(bottom: 20)
          ),
          const Icon(
              Icons.menu_book,
              size: 60,
              color: Colors.green
          ),
          const SizedBox(height: 10),
          Text(
              widget.exercise.title,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
              )
          ),
          const Divider(height: 30),

          // Локальный setState продолжает работать как обычно
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () => setState(() {
                  if (_intensity > 1) _intensity--;
                }),
              ),
              Text(
                  '$_intensity',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold
                  )
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: () => setState(() => _intensity++),
              ),
            ],
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD81B60),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)
                ),
              ),
              onPressed: () {
                final item = PlanItem(
                  id: DateTime.now().toString(),
                  name: widget.exercise.title,
                  duration: widget.exercise.duration,
                  intensity: _intensity,
                  date: DateTime.now(),
                );

                ref.read(planManagerProvider).addToCart(item);

                Navigator.pop(context);
              },
              child: const Text(
                  'ADD TO MY PLAN',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}