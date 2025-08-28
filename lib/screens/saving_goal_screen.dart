import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer.dart';
import '../services/saving_data.dart';

class SavingGoalScreen extends StatefulWidget {
  const SavingGoalScreen({super.key});

  @override
  State<SavingGoalScreen> createState() => _SavingGoalScreenState();
}

class _SavingGoalScreenState extends State<SavingGoalScreen> {
  double _balance = 0.0;
  final _amountController = TextEditingController();

  void _addMoney() {
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    if (amount > 0) {
      setState(() {
        _balance += amount;
        SavingData.addSaving(amount); // เพิ่มบันทึกประวัติ
        _amountController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'ออมเงิน'),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ยอดเงินออม',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            Text(
              '${_balance.toStringAsFixed(2)} บาท',
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'จำนวนเงินที่ต้องการออม (บาท)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addMoney,
              child: const Text('ออมเงิน'),
            ),
          ],
        ),
      ),
    );
  }
}