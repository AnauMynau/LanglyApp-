import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Card2 extends StatelessWidget {
  const Card2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints.expand(
          width: 350,
          height: 450,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/magazines/card_it.jpg'), // Можешь заменить на другое фото
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          children: [
            // Блок с информацией об авторе (вверху)
            const AuthorCard(
              authorName: 'Inayatulla',
              title: 'Advanced Learner',
              imageProvider: AssetImage('assets/magazines/profile_pic.jpg'),
            ),
            // Блок с прогрессом (внизу)
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Text(
                      'Goal: 10/15 min',
                      style: GoogleFonts.lato(
                          fontSize: 32, color: Colors.white),
                    ),
                  ),
                  Positioned(
                    bottom: 70,
                    left: 16,
                    child: RotationTransition(
                      turns: const AlwaysStoppedAnimation(0.9),
                      child: Text(
                        'Keep learning!',
                        style: GoogleFonts.lato(
                            fontSize: 24, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthorCard extends StatefulWidget {
  const AuthorCard({
    super.key,
    required this.authorName,
    required this.title,
    this.imageProvider,
  });

  final String authorName;
  final String title;
  final ImageProvider? imageProvider;

  @override
  State<AuthorCard> createState() => _AuthorCardState();
}

class _AuthorCardState extends State<AuthorCard> {
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 28,
                child: CircleAvatar(
                  radius: 26,
                  backgroundImage: widget.imageProvider,
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.authorName,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  Text(widget.title,
                      style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ],
          ),
          // 2. configure the icon button and behavior
          IconButton(
            icon: Icon(_isFavorited ? Icons.favorite : Icons.favorite_border),
            color: Colors.red,
            onPressed: () {
              // use setState
              setState(() {
                _isFavorited = !_isFavorited;
              });

              // add notification (SnackBar)
              if (_isFavorited) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Added to Favorites!'),
                      duration: Duration(seconds: 1)),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}