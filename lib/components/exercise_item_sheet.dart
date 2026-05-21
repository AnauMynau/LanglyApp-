import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExerciseItemSheet extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;

  const ExerciseItemSheet({super.key, required this.onSave});

  @override
  State<ExerciseItemSheet> createState() => _ExerciseItemSheetState();
}

class _ExerciseItemSheetState extends State<ExerciseItemSheet> {
  final _nameController = TextEditingController();
  double _importance = 1.0;
  DateTime _dueDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Color _selectedColor = Colors.green;
  bool _isComplete = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: ListView(
        children: [
          const Text(
              'Set Study Goal',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
              )
          ),
          const SizedBox(height: 20),

          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
                labelText: 'Focus Topic (e.g. Irregular Verbs)'
            ),
          ),

          // Checkbox
          CheckboxListTile(
            title: const Text('Mark as Urgent?'),
            value: _isComplete,
            onChanged: (val) => setState(() => _isComplete = val!),
          ),

          // Slider
          const Text('Priority Level'),
          Slider(
            value: _importance,
            min: 1.0, max: 5.0, divisions: 4,
            label: _importance.toInt().toString(),
            onChanged: (val) => setState(() => _importance = val),
          ),

          // Date & Time Pickers
          ListTile(
            title: const Text('Target Date'),
            subtitle: Text(DateFormat('yyyy-MM-dd').format(_dueDate)),
            trailing: const Icon(Icons.calendar_month),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _dueDate,
                firstDate: DateTime.now(),
                lastDate: DateTime(2030),
              );
              if (picked != null) setState(() => _dueDate = picked);
            },
          ),

          ElevatedButton(
            onPressed: () {
              widget.onSave({
                'name': _nameController.text,
                'importance': _importance,
                'date': _dueDate,
              });
              Navigator.pop(context);
            },
            child: const Text('Save Goal'),
          ),
        ],
      ),
    );
  }
}