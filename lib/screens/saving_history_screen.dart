import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer.dart';
import '../services/saving_data.dart';

class SavingHistoryScreen extends StatelessWidget {
  const SavingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = SavingData.history;

    return Scaffold(
      appBar: customAppBar(context, 'ประวัติการออม'),
      drawer: const CustomDrawer(),
      body: history.isEmpty
          ? const Center(child: Text('ยังไม่มีประวัติการออม'))
          : ListView.separated(
              padding: const EdgeInsets.all(24),
              itemCount: history.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final item = history[index];
                return ListTile(
                  leading: const Icon(Icons.savings, color: Colors.blue),
                  title: Text('ออม ${item['amount']} บาท'),
                  subtitle: Text('วันที่ ${item['date']}'),
                );
              },
            ),
    );
  }
}