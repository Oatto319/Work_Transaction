import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

// สร้าง Routes ไว้ในไฟล์เดียวกันชั่วคราว
class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String login = '/login';
  static const String notFound = '/notfound';
}

// สร้าง Controller พื้นฐาน
class AuthController extends GetxController {
  final RxBool isLoggedIn = false.obs;
  final RxBool isLoading = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }
  
  void checkLoginStatus() {
    // ตรวจสอบสถานะการล็อกอิน
    isLoading.value = true;
    
    // จำลองการตรวจสอบ (แทนที่ด้วยโลจิกจริง)
    Future.delayed(Duration(seconds: 2), () {
      isLoading.value = false;
      // ส่งไปหน้า home หลังจาก splash
      Get.offNamed(AppRoutes.home);
    });
  }
  
  void login() {
    isLoggedIn.value = true;
    Get.offNamed(AppRoutes.home);
  }
  
  void logout() {
    isLoggedIn.value = false;
    Get.offAllNamed(AppRoutes.login);
  }
}

// Splash Screen
class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                Icons.flutter_dash,
                size: 60,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Form Validate App',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Loading...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Home Screen
class HomeView extends StatelessWidget {
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => authController.logout(),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.home,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Text(
              'Welcome to Home Page!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.toNamed(AppRoutes.login),
              child: Text('Go to Login'),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () => authController.logout(),
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

// Login Screen
class LoginView extends StatelessWidget {
  final AuthController authController = Get.find();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_circle,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 30),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => authController.login(),
                child: Text('Login'),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () => Get.toNamed(AppRoutes.home),
              child: Text('Skip Login'),
            ),
          ],
        ),
      ),
    );
  }
}

// Pages Configuration
class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashView(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeView(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginView(),
    ),
  ];
}

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Hive with error handling
    try {
      final directory = await getApplicationDocumentsDirectory();
      Hive.init(directory.path);
      print('Hive initialized successfully');
    } catch (e) {
      print('Hive initialization error: $e');
      // Continue without Hive if it fails
    }

    // Initialize AuthController globally
    Get.put(AuthController(), permanent: true);
    print('AuthController initialized');

    runApp(const MainApp());
  } catch (e) {
    print('Error initializing app: $e');
    // Fallback app in case of initialization errors
    runApp(MaterialApp(
      title: 'Error App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Initialization Error'),
          backgroundColor: Colors.red,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red),
              SizedBox(height: 16),
              Text(
                'App Initialization Error',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Error: $e',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Try to restart the app
                  runApp(const MainApp());
                },
                child: Text('Try Again'),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Form Validate App',

      // กำหนด initial route เป็น Splash Screen
      initialRoute: AppRoutes.splash,

      // กำหนด pages และ routes
      getPages: AppPages.routes,

      // กำหนด route ที่ไม่พบ
      unknownRoute: GetPage(
        name: AppRoutes.notFound,
        page: () => Scaffold(
          appBar: AppBar(
            title: const Text('Page Not Found'),
            backgroundColor: Colors.red,
          ),
          body: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red),
                SizedBox(height: 16),
                Text(
                  'Page Not Found',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('The page you are looking for does not exist.'),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),

      // Theme configuration
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[700],

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 2,
          centerTitle: true,
        ),

        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18, color: Colors.black),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black54),
          bodySmall: TextStyle(fontSize: 14, color: Colors.black54),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            minimumSize: const Size(88, 48),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            elevation: 2,
          ),
        ),

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.blue[600],
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[400]!, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue[600]!, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red[400]!, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red[600]!, width: 2.0),
          ),
          fillColor: Colors.grey[50],
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          labelStyle: TextStyle(
            color: Colors.grey[700],
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          floatingLabelStyle: TextStyle(
            color: Colors.blue[600],
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}