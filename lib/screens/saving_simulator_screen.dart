import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer.dart';

class SavingSimulatorScreen extends StatefulWidget {
  final double? goalAmount;
  final String? productTitle;

  const SavingSimulatorScreen({super.key, this.goalAmount, this.productTitle});

  @override
  State<SavingSimulatorScreen> createState() => _SavingSimulatorScreenState();
}

class _SavingSimulatorScreenState extends State<SavingSimulatorScreen> {
  final _goalController = TextEditingController();
  final _perDayController = TextEditingController();
  final _monthsController = TextEditingController();
  String? _result;

  @override
  void initState() {
    super.initState();
    if (widget.goalAmount != null) {
      _goalController.text = widget.goalAmount!.toStringAsFixed(2);
    }
  }

  void _calculateByPerDay() {
    final goal = double.tryParse(_goalController.text) ?? 0;
    final perDay = double.tryParse(_perDayController.text) ?? 0;
    if (goal > 0 && perDay > 0) {
      final days = (goal / perDay).ceil();
      final months = (days / 30).ceil();
      final years = (days / 365).ceil();
      setState(() {
        _result =
            'ต้องออม ${perDay.toStringAsFixed(2)} บาท/วัน จะครบ ${goal.toStringAsFixed(2)} บาท ใน\nประมาณ $days วัน\nหรือ $months เดือน\nหรือ $years ปี';
      });
    } else {
      setState(() {
        _result = 'กรุณากรอกข้อมูลให้ถูกต้อง';
      });
    }
  }

  void _calculateByMonths() {
    final goal = double.tryParse(_goalController.text) ?? 0;
    final months = int.tryParse(_monthsController.text) ?? 0;
    if (goal > 0 && months > 0) {
      final perDay = goal / (months * 30);
      setState(() {
        _result =
            'ถ้าอยากได้ ${goal.toStringAsFixed(2)} บาท ใน $months เดือน\nต้องออมวันละ ${perDay.toStringAsFixed(2)} บาท';
      });
    } else {
      setState(() {
        _result = 'กรุณากรอกข้อมูลให้ถูกต้อง';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'คำนวณแผนการออม'),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (widget.productTitle != null)
                Text(
                  'เป้าหมาย: ${widget.productTitle!}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 12),
              TextField(
                controller: _goalController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'เป้าหมายเงินออม (บาท)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              const Text('1. อยากออมต่อวันเท่าไร?'),
              TextField(
                controller: _perDayController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'จำนวนเงินที่อยากออมต่อวัน (บาท)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _calculateByPerDay,
                child: const Text('คำนวณระยะเวลา'),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              const Text('2. อยากได้ภายในกี่เดือน?'),
              TextField(
                controller: _monthsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'จำนวนเดือน',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _calculateByMonths,
                child: const Text('คำนวณจำนวนเงินที่ต้องออมต่อวัน'),
              ),
              const SizedBox(height: 24),
              if (_result != null)
                Text(
                  _result!,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}