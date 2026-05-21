
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Мои избранные')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('favorites').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Пока нет избранных уроков'));
          }

          final favDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: favDocs.length,
            itemBuilder: (context, index) {
              final data = favDocs[index].data() as Map<String, dynamic>;
              final lessonId = data['lessonId'];

              return ListTile(
                leading: const Icon(Icons.bookmark, color: Colors.blue),
                title: Text('Урок ID: $lessonId'),
                subtitle: const Text('Нажми для перехода'),
                onTap: () {
                  // Здесь можно добавить переход к деталям урока
                },
              );
            },
          );
        },
      ),
    );
  }
}