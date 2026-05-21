import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart' as provider;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';
import '../models/app_state_manager.dart';
import '../models/plan_item.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final _nameController = TextEditingController();

  bool _isSelfStudy = true;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = const TimeOfDay(hour: 10, minute: 0);

  final Color _primaryPink = const Color(0xFFD81B60);
  final Color _accentGreen = Colors.green;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: _primaryPink),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: _primaryPink),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  @override
  Widget build(BuildContext context) {
    final manager = ref.read(planManagerProvider);

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.9,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                      'Lesson Planning',
                      style: TextStyle(
                          fontSize: 26, fontWeight: FontWeight.bold
                      )
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
              const SizedBox(height: 25),

              const Text(
                  'STUDY MODE',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 13
                  )
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _buildModeCard(
                      'Self-study',
                      Icons.person_rounded,
                      _isSelfStudy,
                          () => setState(() => _isSelfStudy = true)),
                  const SizedBox(width: 16),
                  _buildModeCard(
                      'Online Lesson',
                      Icons.videocam_rounded,
                      !_isSelfStudy,
                          () => setState(() => _isSelfStudy = false)),
                ],
              ),

              const SizedBox(height: 25),

              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.badge_outlined),
                  labelText: 'Student Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: _accentGreen)
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                  'SCHEDULE',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 13)
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _buildScheduleCard(
                    'Date',
                    Icons.calendar_today_rounded,
                    DateFormat('MMM dd').format(_selectedDate),
                        () => _selectDate(context),
                  ),
                  const SizedBox(width: 16),
                  _buildScheduleCard(
                    'Time',
                    Icons.access_time_rounded,
                    _selectedTime.format(context),
                        () => _selectTime(context),
                  ),
                ],
              ),

              const Divider(height: 50),

              const Text(
                  'Lessons to Schedule',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  )
              ),
              const SizedBox(height: 10),

              // [cite: 1]
              Expanded(
                child: StreamBuilder<List<PlanItem>>(
                  stream: manager.watchCartItems(),
                  builder: (context, snapshot) {
                    final items = snapshot.data ?? [];

                    if (items.isEmpty) {
                      return const Center(child: Text('No lessons selected.'));
                    }

                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                              backgroundColor: Colors.green[50],
                              child: Icon(
                                  Icons.book,
                                  color: _accentGreen
                              )
                          ),
                          title: Text(
                              item.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold
                              )
                          ),
                          subtitle: Text('Goal Lvl: ${item.intensity}'),
                          trailing: IconButton(
                            icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.grey
                            ),
                            onPressed: () => manager.removeFromCart(index),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              StreamBuilder<List<PlanItem>>(
                  stream: manager.watchCartItems(),
                  initialData: manager.cartItems,
                  builder: (context, snapshot) {
                    final items = snapshot.data ?? [];

                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _accentGreen,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                          ),
                          elevation: 4,
                        ),
                        onPressed: items.isEmpty ? null : () {

                          manager.submitOrder(
                              _nameController.text,
                              _isSelfStudy
                          );
                          Navigator.pop(context);
                          provider.Provider.of<AppStateManager>(
                              context, listen: false
                          ).goToLessons();
                        },
                        child: const Text('CONFIRM STUDY PLAN',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            )
                        ),
                      ),
                    );
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModeCard(String title,
      IconData icon, bool isActive, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isActive ? _accentGreen.withOpacity(0.1) : Colors.grey[100],
            borderRadius: BorderRadius.circular(15),
            border: isActive ? Border.all(
                color: _accentGreen,
                width: 2) : Border.all(color: Colors.grey[300]!),
          ),
          child: Column(
            children: [
              Icon(
                  icon,
                  color: isActive ? _accentGreen : Colors.grey[600], size: 30),
              const SizedBox(height: 8),
              Text(
                  title,
                  style: TextStyle(
                      color: isActive ? _accentGreen : Colors.black87,
                      fontWeight: FontWeight.bold, fontSize: 13
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleCard(
      String label,
      IconData icon, String value, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
            boxShadow: [BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 3)],
          ),
          child: Row(
            children: [
              Icon(icon, color: _accentGreen, size: 20),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      label,
                      style: const TextStyle(
                          color: Colors.grey, fontSize: 11
                      )
                  ),
                  Text(
                      value,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}