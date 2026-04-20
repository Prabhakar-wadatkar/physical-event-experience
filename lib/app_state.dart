import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

enum DashboardView { dashboard, events, analytics, attendees, settings }

class EventModel {
  final String id;
  final String name;
  final String date;
  final String status;
  final int attendees;

  EventModel({
    required this.id,
    required this.name,
    required this.date,
    required this.status,
    required this.attendees,
  });
}

class AppState extends ChangeNotifier {
  User? _user;
  User? get user => _user;
  bool get isLoggedIn => _user != null;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppState() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  DashboardView _currentView = DashboardView.dashboard;
  DashboardView get currentView => _currentView;

  final List<EventModel> _events = [
    EventModel(id: '1', name: 'Global Tech Summit', date: '2026-05-12', status: 'Active', attendees: 12400),
    EventModel(id: '2', name: 'Digital Art Expo', date: '2026-06-15', status: 'Planning', attendees: 4500),
    EventModel(id: '3', name: 'Web3 Hackathon', date: '2026-07-02', status: 'Draft', attendees: 2100),
  ];

  List<EventModel> get events => _events;

  Future<void> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        // Use Firebase Popup for Web - standard and most stable approach
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        
        // Add custom parameters if needed
        googleProvider.setCustomParameters({
          'login_hint': 'user@example.com'
        });

        await _auth.signInWithPopup(googleProvider);
      } else {
        // Mobile implementation would go here with google_sign_in package
        debugPrint("Google Sign-In for Mobile currently not configured.");
      }
    } catch (e) {
      debugPrint("Login Error: $e");
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _currentView = DashboardView.dashboard;
    notifyListeners();
  }

  void setView(DashboardView view) {
    _currentView = view;
    notifyListeners();
  }

  void addEvent(EventModel event) {
    _events.add(event);
    notifyListeners();
  }

  void removeEvent(String id) {
    _events.removeWhere((e) => e.id == id);
    notifyListeners();
  }
}
