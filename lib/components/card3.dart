import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Card3 extends StatelessWidget {
  const Card3({super.key});

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
            image: AssetImage('assets/magazines/english.jpg'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.book, color: Colors.white, size: 40),
                  const SizedBox(height: 8),
                  Text(
                    'Trending Topics',
                    style: GoogleFonts.lato(
                        fontSize: 28, color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _buildChip('Grammar'),
                      _buildChip('Travel'),
                      _buildChip('Business'),
                      _buildChip('Slang'),
                      _buildChip('Movies'),
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

  Widget _buildChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.white.withOpacity(0.7),
    );
  }
}