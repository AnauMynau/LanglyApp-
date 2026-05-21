import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/lesson.dart';
import '../models/plan_manager.dart';
import '../models/app_state_manager.dart';
import '../services/firestore_service.dart';

class Card1 extends StatelessWidget {
  final Lesson lesson;

  const Card1({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/learn/${lesson.id}'),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            tag: 'hero-image-${lesson.id}',
            child: Material(
              type: MaterialType.transparency,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  lesson.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.black.withOpacity(0.4),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    lesson.category,
                    style: GoogleFonts.lato(color: Colors.white70)),
                const Spacer(),
                Text(
                    lesson.title,
                    style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    )
                ),
              ],
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: AnimatedHeartButton(lessonId: lesson.id),
          ),
        ],
      ),
    );
  }
}

// (Local State + Delayed Global Update)

class AnimatedHeartButton extends StatefulWidget {
  final String lessonId;

  const AnimatedHeartButton({super.key, required this.lessonId});

  @override
  State<AnimatedHeartButton> createState() => _AnimatedHeartButtonState();
}

class _AnimatedHeartButtonState extends State<AnimatedHeartButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  bool? _isFavLocal;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween<double>(begin: 1.0, end: 1.6).chain(CurveTween(
              curve: Curves.easeOutCubic)), weight: 50
      ),
      TweenSequenceItem(
          tween: Tween<double>(begin: 1.6, end: 1.0).chain(
              CurveTween(curve: Curves.bounceOut)),
          weight: 50
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _isFavLocal ??= Provider.of<AppStateManager>(context, listen: false)
          .isFavorite(widget.lessonId);

    return ScaleTransition(
      scale: _scaleAnimation,
      child: IconButton(
        icon: Icon(
          _isFavLocal! ? Icons.favorite : Icons.favorite_border,
          color: _isFavLocal! ? Colors.redAccent : Colors.white,
          size: 32,
        ),
        onPressed: () async {
          final newState = !_isFavLocal!;
          setState(() {
            _isFavLocal = newState;
          });

          Provider.of<AppStateManager>(context, listen: false)
              .toggleFavorite(widget.lessonId);

          final firestore = FirebaseFirestore.instance;
          if (newState) {
            await firestore.collection('favorites').doc(widget.lessonId).set({
              'lessonId': widget.lessonId,
              'addedAt': DateTime.now(),
            });
          } else {
            await firestore.collection('favorites')
                .doc(widget.lessonId).delete();
          }
        },
      ),
    );
  }
}