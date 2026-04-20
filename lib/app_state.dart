import 'package:flutter/material.dart';

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
  DashboardView _currentView = DashboardView.dashboard;
  DashboardView get currentView => _currentView;

  final List<EventModel> _events = [
    EventModel(id: '1', name: 'Global Tech Summit', date: '2026-05-12', status: 'Active', attendees: 12400),
    EventModel(id: '2', name: 'Digital Art Expo', date: '2026-06-15', status: 'Planning', attendees: 4500),
    EventModel(id: '3', name: 'Web3 Hackathon', date: '2026-07-02', status: 'Draft', attendees: 2100),
  ];

  List<EventModel> get events => _events;

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
