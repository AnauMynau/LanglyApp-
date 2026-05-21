import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My favorites')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('favorites').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text(
                'There are no selected lessons yet')
            );
          }

          final favDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: favDocs.length,
            itemBuilder: (context, index) {
              final data = favDocs[index].data() as Map<String, dynamic>;
              final lessonId = data['lessonId'];

              return ListTile(
                leading: const Icon(Icons.bookmark, color: Colors.blue),
                title: Text('Lesson ID: $lessonId'),
                subtitle: const Text('Click to go'),
                onTap: () {
                },
              );
            },
          );
        },
      ),
    );
  }
}