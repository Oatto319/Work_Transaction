import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer.dart';
import '../services/saving_data.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = SavingData.history;

    double total = 0;
    Map<String, double> perMonth = {};

    for (var item in history) {
      total += (item['amount'] as double);
      String month = item['date'].substring(0, 7); // yyyy-MM
      perMonth[month] = (perMonth[month] ?? 0) + (item['amount'] as double);
    }

    return Scaffold(
      appBar: customAppBar(context, 'สถิติการออม'),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ยอดเงินออมทั้งหมด', style: Theme.of(context).textTheme.titleMedium),
            Text(
              '${total.toStringAsFixed(2)} บาท',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 32),
            Text('ยอดออมรายเดือน', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Expanded(
              child: perMonth.isEmpty
                  ? const Center(child: Text('ยังไม่มีข้อมูลออมเงิน'))
                  : ListView(
                      children: perMonth.entries.map((e) {
                        return ListTile(
                          leading: const Icon(Icons.calendar_month, color: Colors.green),
                          title: Text('${e.key}'),
                          trailing: Text('${e.value.toStringAsFixed(2)} บาท'),
                        );
                      }).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}