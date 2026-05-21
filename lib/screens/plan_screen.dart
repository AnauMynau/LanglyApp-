import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';
import '../models/plan_item.dart';

class PlanScreen extends ConsumerWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manager = ref.read(planManagerProvider);

    return Scaffold(
      appBar: AppBar(
          title: const Text('Scheduled Lessons'), centerTitle: true
      ),
      body: StreamBuilder<List<PlanItem>>(
        stream: manager.watchOrders(),
        initialData: const [],
        builder: (context, snapshot) {

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final lessons = snapshot.data ?? [];

          if (lessons.isEmpty) {
            return const Center(
              child: Text('No lessons scheduled yet.'
                  '\nGo to Learn tab to add some!',
                  textAlign: TextAlign.center),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: lessons.length,
            itemBuilder: (context, index) {
              final item = lessons[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Student: '
                                '${
                                item.studentName.isEmpty ?
                                "Guest" : item.studentName
                            }',
                            style:
                            const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                  item.isSelfStudy ?
                                  Icons.person : Icons.videocam,
                                  size: 16,
                                  color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                  item.isSelfStudy ?
                                  'Self-study' : 'Online',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                      const Divider(),
                      Text(
                          item.name,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold)
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                              Icons.calendar_today,
                              size: 16,
                              color: Colors.pink
                          ),
                          const SizedBox(width: 8),
                          Text(DateFormat('yyyy-MM-dd').format(item.date)),
                          const Spacer(),
                          Text(
                              'Level: ${item.intensity}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500)
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}