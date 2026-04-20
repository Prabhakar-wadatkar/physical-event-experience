import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class DashboardLayout extends StatelessWidget {
  final Widget child;
  const DashboardLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070B14),
      body: Row(
        children: [
          const _Sidebar(),
          Expanded(
            child: Column(
              children: [
                const _Header(),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  const _Sidebar();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Container(
      width: 280,
      color: Colors.black.withValues(alpha: 0.3),
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.hub, color: Color(0xFF00E5FF), size: 32),
              const SizedBox(width: 15),
              Text('EVENTOS', style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
            ],
          ),
          const SizedBox(height: 60),
          _SidebarItem(
            icon: Icons.dashboard_outlined,
            title: 'Dashboard',
            isActive: appState.currentView == DashboardView.dashboard,
            onTap: () => appState.setView(DashboardView.dashboard),
          ),
          _SidebarItem(
            icon: Icons.event_note_outlined,
            title: 'Events',
            isActive: appState.currentView == DashboardView.events,
            onTap: () => appState.setView(DashboardView.events),
          ),
          _SidebarItem(
            icon: Icons.analytics_outlined,
            title: 'Analytics',
            isActive: appState.currentView == DashboardView.analytics,
            onTap: () => appState.setView(DashboardView.analytics),
          ),
          _SidebarItem(
            icon: Icons.people_outline,
            title: 'Attendees',
            isActive: appState.currentView == DashboardView.attendees,
            onTap: () => appState.setView(DashboardView.attendees),
          ),
          const Spacer(),
          _SidebarItem(
            icon: Icons.settings_outlined,
            title: 'Settings',
            isActive: appState.currentView == DashboardView.settings,
            onTap: () => appState.setView(DashboardView.settings),
          ),
          const Divider(color: Colors.white10, height: 40),
          ListTile(
            onTap: () {
              // Exit logic or just stay
            },
            leading: const Icon(Icons.exit_to_app, color: Colors.white30, size: 20),
            title: const Text('Exit System', style: TextStyle(color: Colors.white30, fontSize: 14)),
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
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF00E5FF).withValues(alpha: 0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: isActive ? const Color(0xFF00E5FF) : Colors.white30, size: 20),
        title: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.white38,
            fontSize: 14,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha: 0.05)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('System Command Center', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Row(
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none, color: Colors.white30, size: 20)),
              const SizedBox(width: 20),
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF00E5FF).withValues(alpha: 0.3), width: 2),
                ),
                child: const Center(child: Icon(Icons.admin_panel_settings, color: Color(0xFF00E5FF), size: 20)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
