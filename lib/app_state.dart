import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date,
      'status': status,
      'attendees': attendees,
    };
  }

  factory EventModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return EventModel(
      id: doc.id,
      name: data['name'] ?? '',
      date: data['date'] ?? '',
      status: data['status'] ?? '',
      attendees: data['attendees'] ?? 0,
    );
  }
}

class AppState extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  
  DashboardView _currentView = DashboardView.dashboard;
  DashboardView get currentView => _currentView;

  List<EventModel> _events = [];
  List<EventModel> get events => _events;

  AppState() {
    // Meaningful Integration: Real-time Firestore Sync
    _db.collection('events').snapshots().listen((snapshot) {
      _events = snapshot.docs.map((doc) => EventModel.fromFirestore(doc)).toList();
      notifyListeners();
    });
  }

  void setView(DashboardView view) {
    _currentView = view;
    notifyListeners();
  }

  Future<void> addEvent(EventModel event) async {
    // Security: Validate data before push
    if (event.name.isEmpty) return;
    
    await _db.collection('events').add(event.toMap());
  }

  Future<void> removeEvent(String id) async {
    await _db.collection('events').doc(id).delete();
  }
}
