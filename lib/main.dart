import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app_state.dart';
import 'landing_page.dart';
import 'dashboard/dashboard_layout.dart';
import 'dashboard/main_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBRnFEpU1XNMh1DHh50zjePXJAs7Qr8aQo",
        authDomain: "physical-event-exp-26.firebaseapp.com",
        projectId: "physical-event-exp-26",
        storageBucket: "physical-event-exp-26.firebasestorage.app",
        messagingSenderId: "322900632341",
        appId: "1:322900632341:web:3a6500cb7a529cebc33f1c",
      ),
    );
  } catch (e) {
    debugPrint("Firebase Initialization Error: $e");
    // Continue even if Firebase fails, as we are removing the login wall
  }

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

class MainGate extends StatefulWidget {
  const MainGate({super.key});

  @override
  State<MainGate> createState() => _MainGateState();
}

class _MainGateState extends State<MainGate> {
  bool _showDashboard = false;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    if (_showDashboard) {
      return DashboardLayout(
        child: _buildCurrentView(appState.currentView),
      );
    } else {
      return LandingPage(onEnterDashboard: () {
        setState(() {
          _showDashboard = true;
        });
      });
    }
  }

  Widget _buildCurrentView(DashboardView view) {
    switch (view) {
      case DashboardView.dashboard:
        return const MainDashboardView();
      case DashboardView.events:
        return const EventsListView();
      case DashboardView.analytics:
        return const AnalyticsOverview();
      case DashboardView.attendees:
        return const Center(child: Text('Attendees Management Coming Soon'));
      case DashboardView.settings:
        return const Center(child: Text('System Settings Coming Soon'));
    }
  }
}

class EventsListView extends StatelessWidget {
  const EventsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(40),
      child: EventsTableSection(),
    );
  }
}

class AnalyticsOverview extends StatelessWidget {
  const AnalyticsOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Advanced Analytics Console Rendering...'));
  }
}
