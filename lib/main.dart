import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'landing_page.dart';
import 'dashboard/dashboard_layout.dart';
import 'dashboard/main_view.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const PhysicalEventApp(),
    ),
  );
}

class PhysicalEventApp extends StatelessWidget {
  const PhysicalEventApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EVENTOS - Spatial Venue Engine',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF00E5FF),
        scaffoldBackgroundColor: const Color(0xFF070B14),
        useMaterial3: true,
      ),
      home: const MainGate(),
    );
  }
}

class MainGate extends StatelessWidget {
  const MainGate({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    if (appState.isLoggedIn) {
      return const DashboardLayout(child: MainDashboardView());
    } else {
      return const LandingPage();
    }
  }
}
