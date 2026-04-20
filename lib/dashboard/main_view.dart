import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class MainDashboardView extends StatelessWidget {
  const MainDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Live Overview', style: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                onPressed: () => _showAddEventDialog(context),
                icon: const Icon(Icons.add),
                label: const Text('Create New Event'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00E5FF),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              _StatCard(title: 'Active Beacons', value: '142', color: Colors.greenAccent),
              const SizedBox(width: 20),
              _StatCard(title: 'Network Load', value: '12%', color: Colors.orangeAccent),
              const SizedBox(width: 20),
              _StatCard(title: 'Safety Status', value: 'Secure', color: Colors.blueAccent),
            ],
          ),
          const SizedBox(height: 40),
          Text('Ongoing Projects', style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const EventsTableSection(),
        ],
      ),
    );
  }

  void _showAddEventDialog(BuildContext context) {
    final nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF151B2D),
        title: const Text('New Event'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: 'Event Name', labelStyle: TextStyle(color: Colors.white38)),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                Provider.of<AppState>(context, listen: false).addEvent(
                  EventModel(id: DateTime.now().toString(), name: nameController.text, date: '2026-08-01', status: 'Draft', attendees: 0),
                );
              }
              Navigator.pop(context);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}

class EventsTableSection extends StatelessWidget {
  const EventsTableSection({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final events = appState.events;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Event Name', style: TextStyle(color: Colors.white38))),
          DataColumn(label: Text('Date', style: TextStyle(color: Colors.white38))),
          DataColumn(label: Text('Status', style: TextStyle(color: Colors.white38))),
          DataColumn(label: Text('Attendees', style: TextStyle(color: Colors.white38))),
          DataColumn(label: Text('Actions', style: TextStyle(color: Colors.white38))),
        ],
        rows: events.map((e) => DataRow(
          cells: [
            DataCell(Text(e.name, style: const TextStyle(fontWeight: FontWeight.bold))),
            DataCell(Text(e.date)),
            DataCell(_StatusBadge(status: e.status)),
            DataCell(Text(e.attendees.toString())),
            DataCell(IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
              onPressed: () => appState.removeEvent(e.id),
            )),
          ],
        )).toList(),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title, value;
  final Color color;
  const _StatCard({required this.title, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white38, fontSize: 13)),
            const SizedBox(height: 10),
            Text(value, style: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color = Colors.grey;
    if (status == 'Active') color = Colors.greenAccent;
    if (status == 'Planning') color = Colors.blueAccent;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(status, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }
}
