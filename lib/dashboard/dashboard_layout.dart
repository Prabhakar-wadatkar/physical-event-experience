import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class DashboardLayout extends StatefulWidget {
  final Widget child;
  const DashboardLayout({super.key, required this.child});

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070B14),
      body: Row(
        children: [
          _Sidebar(),
          Expanded(
            child: Column(
              children: [
                _Header(),
                Expanded(child: widget.child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      color: Colors.black.withOpacity(0.3),
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.hub, color: Color(0xFF00E5FF), size: 32),
              const SizedBox(width: 15),
              Text('EVENTOS', style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.w900)),
            ],
          ),
          const SizedBox(height: 60),
          _SidebarItem(icon: Icons.dashboard_outlined, title: 'Dashboard', isActive: true),
          _SidebarItem(icon: Icons.event_note_outlined, title: 'Events', isActive: false),
          _SidebarItem(icon: Icons.analytics_outlined, title: 'Analytics', isActive: false),
          _SidebarItem(icon: Icons.people_outline, title: 'Attendees', isActive: false),
          const Spacer(),
          _SidebarItem(icon: Icons.settings_outlined, title: 'Settings', isActive: false),
          const Divider(color: Colors.white10, height: 40),
          ListTile(
            onTap: () {
              Provider.of<AppState>(context, listen: false).logout();
            },
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text('Sign Out', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isActive;
  const _SidebarItem({required this.icon, required this.title, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF00E5FF).withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: isActive ? const Color(0xFF00E5FF) : Colors.white30),
        title: Text(title, style: TextStyle(color: isActive ? Colors.white : Colors.white38, fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Welcome back, Admin', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Row(
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none, color: Colors.white30)),
              const SizedBox(width: 20),
              const CircleAvatar(backgroundColor: Color(0xFF00E5FF), child: Text('A', style: TextStyle(color: Colors.black))),
            ],
          ),
        ],
      ),
    );
  }
}
