import 'package:flutter/material.dart';
import 'utils/constants.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: AppConfig.primaryColor,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppConfig.primaryColor,
            foregroundColor: Colors.white,
            elevation: 2,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
        cardTheme: CardThemeData(
          elevation: AppConfig.cardElevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(AppConfig.borderRadius),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue.shade400,
      ),
      // เปลี่ยนหน้าแรกเป็น LoginScreen
      home: const LoginScreen(),
      // เพิ่ม routes สำหรับ navigation
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/home': (context) => const HomeScreen(), // เพิ่มบรรทัดนี้
      },
    );
  }
}

/// Development Dashboard
class DevelopmentDashboard extends StatelessWidget {
  const DevelopmentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter API Transaction - Development'),
        backgroundColor: AppConfig.primaryColor,
      ),
      body: ListView(
        padding: AppConfig.defaultPadding,
        children: [
          _buildSectionCard(
            title: '🎯 Project Overview',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Flutter Transaction Management App with API Integration'),
                SizedBox(height: 8),
                Text(
                  'Features: Transaction CRUD, Statistics, User Authentication',
                ),
                SizedBox(height: 8),
                Text('API: REST API with JSON responses'),
              ],
            ),
          ),

          const SizedBox(height: 16),

          _buildSectionCard(
            title: '👥 Team Tasks Distribution',
            content: Column(
              children: const [
                // ใช้ const เพื่อประสิทธิภาพ
                _TaskItem(
                  title: '📱 Screens & UI',
                  description:
                      'TransactionScreen, AddTransactionScreen, StatisticsScreen',
                  assignee: 'UI/UX Developer',
                  color: Colors.green,
                ),
                _TaskItem(
                  title: '🌐 API Services',
                  description: 'ApiService, AuthService, Data Management',
                  assignee: 'Backend Developer',
                  color: Colors.orange,
                ),
                _TaskItem(
                  title: '📊 Models & Data',
                  description: 'Transaction Model, User Model, Data Validation',
                  assignee: 'Data Modeler',
                  color: Colors.purple,
                ),
                _TaskItem(
                  title: '🎨 Widgets & Components',
                  description: 'TransactionCard, StatsCard, Custom Widgets',
                  assignee: 'Widget Developer',
                  color: Colors.blue,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          _buildSectionCard(
            title: '📋 Implementation Guidelines',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('1. Create your assigned files in appropriate folders'),
                Text('2. Use snake_case for files'),
                Text('3. Add documentation & comments'),
                Text('4. Test your components before integration'),
                Text('5. Update imports in main.dart when ready'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildSectionCard({
    required String title,
    required Widget content,
  }) {
    return Card(
      child: Padding(
        padding: AppConfig.defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            content,
          ],
        ),
      ),
    );
  }
}

// ย้าย TaskItem ออกมาเป็น StatelessWidget เพื่อความสะอาดและใช้ const ได้
class _TaskItem extends StatelessWidget {
  final String title;
  final String description;
  final String assignee;
  final Color color;

  const _TaskItem({
    required this.title,
    required this.description,
    required this.assignee,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 4),
          Text(description, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          Text(
            'Assignee: $assignee',
            style: const TextStyle(fontSize: 11, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}

/// Placeholder Screen (Reusable)
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.construction, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              '$title Screen',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'This screen is under development',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
