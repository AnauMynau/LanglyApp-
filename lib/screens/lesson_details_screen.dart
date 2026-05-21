import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // 1. Импортируем Riverpod
import '../models/lesson.dart';
import '../providers.dart';
import 'exercise_screen.dart';

class LessonDetailsScreen extends ConsumerWidget {
  final Lesson lesson;

  const LessonDetailsScreen({
    super.key,
    required this.lesson,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isSaved = ref.watch(repositoryProvider)
        .savedLessonIds.contains(lesson.id);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            actions: [
              IconButton(
                icon: Icon(
                  isSaved ? Icons.bookmark : Icons.bookmark_border,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (isSaved) {
                    ref.read(repositoryProvider.notifier)
                        .removeSavedLesson(lesson.id);
                  } else {
                    ref.read(repositoryProvider.notifier)
                        .addSavedLesson(lesson.id);
                  }
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                  lesson.title,
                  style: const TextStyle(
                      color: Colors.white
                  )
              ),
              background: Hero(
                tag: 'hero-image-${lesson.id}',
                child: Material(
                  type: MaterialType.transparency,
                  child: Image.asset(
                    lesson.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final exercise = lesson.exercises[index];

                return Dismissible(
                  key: Key(exercise.title),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${exercise.title} hidden')),
                    );
                  },
                  child: ListTile(
                    leading: const Icon(
                        Icons.play_circle_fill, color: Colors.green
                    ),
                    title: Text(exercise.title),
                    subtitle: Text(exercise.duration),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => ExerciseScreen(
                          exercise: exercise,
                        ),
                      );
                    },
                  ),
                );
              },
              childCount: lesson.exercises.length,
            ),
          ),
        ],
      ),
    );
  }
}