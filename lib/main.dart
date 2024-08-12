import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mess_mgmt/Global/store/app_state_store.dart';
import 'package:mess_mgmt/Global/theme/app_theme.dart';
import 'package:mess_mgmt/features/auth/screens/login_screen.dart';
import 'package:mess_mgmt/features/dashboard/screens/dashboard.dart';
import 'package:mess_mgmt/features/dashboard/stores/dashboard_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appState.initialization();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutt',
      theme: AppTheme.lightTheme(),
      home: Observer(
        builder: (context) {
          final jwt = appState.jwt;
          if (jwt != null) {
            return const DashboardScreen();
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
