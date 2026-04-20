import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'dart:async';
import 'dart:math' as math;
import 'app_state.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _featuresKey = GlobalKey();
  final GlobalKey _dashboardKey = GlobalKey();
  final GlobalKey _storiesKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    Scrollable.ensureVisible(key.currentContext!,
        duration: const Duration(milliseconds: 1000), curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 1000;

    return Scaffold(
      body: Stack(
        children: [
          const ParticleBackground(),
          Positioned(top: -200, right: -100, child: _GlowOrb(color: const Color(0xFF00E5FF).withOpacity(0.2), size: 600)),
          Positioned(bottom: -200, left: -100, child: _GlowOrb(color: const Color(0xFFA100FF).withOpacity(0.15), size: 700)),

          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Navbar(
                  onHome: () => _scrollTo(_homeKey),
                  onFeatures: () => _scrollTo(_featuresKey),
                  onDashboard: () => _scrollTo(_dashboardKey),
                  onStories: () => _scrollTo(_storiesKey),
                ),
                HeroSection(key: _homeKey, isMobile: isMobile),
                const LiveActivityTicker(),
                const FeaturesSection(),
                DashboardPreview(key: _dashboardKey, isMobile: isMobile),
                SuccessStoriesSection(key: _storiesKey, isMobile: isMobile),
                const NewsletterSection(),
                const Footer(),
              ],
            ),
          ),

          Positioned(
            bottom: 40,
            right: 40,
            child: FadeInUp(
              delay: const Duration(seconds: 2),
              child: FloatingActionButton.extended(
                onPressed: () => _showInquiryDialog(context),
                backgroundColor: const Color(0xFF00E5FF),
                foregroundColor: Colors.black,
                icon: const Icon(Icons.chat_bubble_outline),
                label: const Text('Live Support', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showInquiryDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => const InquiryDialog());
  }
}

class Navbar extends StatelessWidget {
  final VoidCallback onHome, onFeatures, onDashboard, onStories;
  const Navbar({super.key, required this.onHome, required this.onFeatures, required this.onDashboard, required this.onStories});

  @override
  Widget build(BuildContext context) {
    bool isSmall = MediaQuery.of(context).size.width < 1000;
    final appState = Provider.of<AppState>(context, listen: false);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FadeInLeft(
            child: InkWell(
              onTap: onHome,
              borderRadius: BorderRadius.circular(12),
              child: Row(
                children: [
                  Container(
                    width: 45, height: 45,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF00E5FF), Color(0xFF1DE9B6)]),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [BoxShadow(color: const Color(0xFF00E5FF).withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 5))],
                    ),
                    child: const Icon(Icons.hub, color: Colors.black, size: 28),
                  ),
                  const SizedBox(width: 15),
                  Text('EVENTOS', style: GoogleFonts.outfit(fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: 2)),
                ],
              ),
            ),
          ),
          if (!isSmall)
            FadeInRight(
              child: Row(
                children: [
                  _NavButton(title: 'Overview', onTap: onHome),
                  _NavButton(title: 'Solutions', onTap: onFeatures),
                  _NavButton(title: 'Real-time Console', onTap: onDashboard),
                  _NavButton(title: 'Results', onTap: onStories),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () => appState.login(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.08),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                      side: BorderSide(color: Colors.white.withOpacity(0.1)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: const Text('Access Dashboard'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ... All other widgets (HeroSection, FeaturesSection, DashboardPreview, etc.) remain as they were in the previous turn ...
// ... I will include them here but ensure they look at the AppState if needed ...

class HeroSection extends StatelessWidget {
  final bool isMobile;
  const HeroSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 30 : 80, vertical: isMobile ? 80 : 160),
      child: Column(
        children: [
          FadeInDown(child: Badge(label: Padding(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), child: Text('V2.0 PRO', style: GoogleFonts.inter(fontWeight: FontWeight.bold))), backgroundColor: const Color(0xFF00E5FF))),
          const SizedBox(height: 40),
          FadeInUp(duration: const Duration(seconds: 1), child: Text('Physical Events\nEvolved With AI', textAlign: TextAlign.center, style: GoogleFonts.outfit(fontSize: isMobile ? 56 : 110, fontWeight: FontWeight.w900, height: 0.95, letterSpacing: -2, foreground: Paint()..shader = const LinearGradient(colors: [Colors.white, Color(0xFF80EEFF), Color(0xFFA100FF)]).createShader(const Rect.fromLTWH(0.0, 0.0, 800.0, 100.0))))),
          const SizedBox(height: 30),
          FadeIn(delay: const Duration(milliseconds: 500), child: SizedBox(width: 800, child: Text('The ultimate spatial engine for real-world attractions. Track millions of data points, engage thousands of users with AR, and automate venue logistics in one unified platform.', textAlign: TextAlign.center, style: GoogleFonts.inter(fontSize: 20, color: Colors.white60, height: 1.6)))),
          const SizedBox(height: 60),
          FadeInUp(delay: const Duration(milliseconds: 800), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _GlowButton(text: 'Deploy Space Engine', color: const Color(0xFF00E5FF), onTap: () => appState.login()),
            const SizedBox(width: 25),
            _OutlineButton(text: 'Read Spec Sheet'),
          ])),
        ],
      ),
    );
  }
}

// ... Including supporting widgets from previous main.dart ...

class DashboardPreview extends StatelessWidget {
  final bool isMobile;
  const DashboardPreview({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 120),
      child: Column(
        children: [
          FadeInDown(
            child: Text(
              'Real-time Venue OS',
              style: GoogleFonts.outfit(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          const Text('A unified command center for your entire physical footprint.', style: TextStyle(color: Colors.white38, fontSize: 18)),
          const SizedBox(height: 80),
          FadeInUp(
            child: Container(
              width: 1200,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(colors: [Colors.white.withOpacity(0.2), Colors.transparent, const Color(0xFF00E5FF).withOpacity(0.2)]),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                  child: Container(
                    padding: const EdgeInsets.all(40),
                    color: Colors.white.withOpacity(0.03),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _DashboardStat(label: 'Total Active Users', value: '14,204', trend: '+12%', isPositive: true),
                            _DashboardStat(label: 'AR Interaction Rate', value: '88.4%', trend: '-2%', isPositive: false),
                            _DashboardStat(label: 'Venue Load', value: '64%', trend: 'Optimum', isPositive: true),
                            _DashboardStat(label: 'Avg Dwell Time', value: '42m', trend: '+5m', isPositive: true),
                          ],
                        ),
                        const SizedBox(height: 60),
                        SizedBox(
                          height: 350,
                          child: LineChart(_sampleChartData()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  LineChartData _sampleChartData() {
    return LineChartData(
      gridData: const FlGridData(show: false),
      titlesData: const FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: const [FlSpot(0, 3), FlSpot(2.6, 2), FlSpot(4.9, 5), FlSpot(6.8, 3.1), FlSpot(8, 4), FlSpot(9.5, 3), FlSpot(11, 4)],
          isCurved: true,
          color: const Color(0xFF00E5FF),
          barWidth: 6,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(colors: [const Color(0xFF00E5FF).withOpacity(0.3), Colors.transparent], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
        ),
      ],
    );
  }
}

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 100),
      child: Wrap(
        spacing: 40, runSpacing: 40, alignment: WrapAlignment.center,
        children: [
          _FeatureCardPro(icon: Icons.auto_awesome, title: 'Spatial AI', desc: 'Predict congestion before it happens.', color: const Color(0xFF00E5FF)),
          _FeatureCardPro(icon: Icons.animation, title: 'Immersive Mesh', desc: 'Low-latency AR for thousands of users.', color: const Color(0xFFA100FF)),
          _FeatureCardPro(icon: Icons.shield_outlined, title: 'Privacy Shield', desc: 'GDPR-compliant anonymous tracking.', color: const Color(0xFF1DE9B6)),
        ],
      ),
    );
  }
}

class SuccessStoriesSection extends StatelessWidget {
  final bool isMobile;
  const SuccessStoriesSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 120),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Global Deployments', style: GoogleFonts.outfit(fontSize: 42, fontWeight: FontWeight.bold)),
            TextButton(onPressed: () {}, child: const Text('Case Studies →', style: TextStyle(color: Color(0xFF00E5FF)))),
          ]),
          const SizedBox(height: 60),
          _StoryCard(title: 'Global Tech Expo', location: 'San Francisco, CA', metric: '92% Active', tag: 'ENTERPRISE'),
          const SizedBox(height: 30),
          _StoryCard(title: 'Electric Odyssey', location: 'Berlin, DE', metric: '1.2M Beats', tag: 'FESTIVAL'),
        ],
      ),
    );
  }
}

class NewsletterSection extends StatelessWidget {
  const NewsletterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 120),
      child: Center(
        child: Container(
          width: 900, padding: const EdgeInsets.all(60),
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.04), borderRadius: BorderRadius.circular(40), border: Border.all(color: Colors.white.withOpacity(0.05))),
          child: Column(children: [
            const Icon(Icons.mark_email_unread_outlined, size: 48, color: Color(0xFF00E5FF)),
            const SizedBox(height: 30),
            Text('Stay Updated', style: GoogleFonts.outfit(fontSize: 36, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            _EmailInput(),
          ]),
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(80), color: Colors.black.withOpacity(0.5),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
          _SocialIcon(Icons.facebook), _SocialIcon(Icons.link), _SocialIcon(Icons.photo_camera),
        ]),
        const SizedBox(height: 50),
        Text('© 2026 EVENTOS LABS.', style: TextStyle(color: Colors.white.withOpacity(0.2), letterSpacing: 2, fontSize: 12)),
      ]),
    );
  }
}

class ParticleBackground extends StatefulWidget {
  const ParticleBackground({super.key});
  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = List.generate(40, (_) => _Particle());
  @override
  void initState() { super.initState(); _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat(); }
  @override
  void dispose() { _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => AnimatedBuilder(animation: _controller, builder: (context, child) => CustomPaint(size: Size.infinite, painter: _ParticlePainter(_particles)));
}

class _Particle { double x = math.Random().nextDouble(); double y = math.Random().nextDouble(); double size = math.Random().nextDouble() * 2 + 1; double speed = math.Random().nextDouble() * 0.001 + 0.0002; }
class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  _ParticlePainter(this.particles);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.1);
    for (var p in particles) { p.y -= p.speed; if (p.y < 0) p.y = 1.0; canvas.drawCircle(Offset(p.x * size.width, p.y * size.height), p.size, paint); }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _GlowOrb extends StatelessWidget {
  final Color color; final double size;
  const _GlowOrb({required this.color, required this.size});
  @override
  Widget build(BuildContext context) => Container(width: size, height: size, decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [BoxShadow(color: color, blurRadius: 150, spreadRadius: 50)]));
}

class _NavButton extends StatelessWidget {
  final String title; final VoidCallback onTap;
  const _NavButton({required this.title, required this.onTap});
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: InkWell(onTap: onTap, child: Text(title, style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white70))));
}

class _GlowButton extends StatelessWidget {
  final String text; final Color color; final VoidCallback onTap;
  const _GlowButton({required this.text, required this.color, required this.onTap});
  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(boxShadow: [BoxShadow(color: color.withOpacity(0.4), blurRadius: 25, offset: const Offset(0, 10))]),
    child: ElevatedButton(onPressed: onTap, style: ElevatedButton.styleFrom(backgroundColor: color, foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))), child: Text(text, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16))),
  );
}

class _OutlineButton extends StatelessWidget {
  final String text;
  const _OutlineButton({required this.text});
  @override
  Widget build(BuildContext context) => OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: Colors.white24, width: 2), padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))), child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)));
}

class _DashboardStat extends StatelessWidget {
  final String label, value, trend; final bool isPositive;
  const _DashboardStat({required this.label, required this.value, required this.trend, required this.isPositive});
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(color: Colors.white38, fontSize: 12)), const SizedBox(height: 5), Text(value, style: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.bold)), const SizedBox(height: 5), Text(trend, style: TextStyle(color: isPositive ? Colors.greenAccent : Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 12))]);
}

class _FeatureCardPro extends StatelessWidget {
  final IconData icon; final String title, desc; final Color color;
  const _FeatureCardPro({required this.icon, required this.title, required this.desc, required this.color});
  @override
  Widget build(BuildContext context) => Container(width: 350, padding: const EdgeInsets.all(40), decoration: BoxDecoration(color: Colors.white.withOpacity(0.04), borderRadius: BorderRadius.circular(30), border: Border.all(color: Colors.white.withOpacity(0.05))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle), child: Icon(icon, color: color, size: 32)), const SizedBox(height: 30), Text(title, style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold)), const SizedBox(height: 15), Text(desc, style: const TextStyle(color: Colors.white54, height: 1.5))]));
}

class _StoryCard extends StatelessWidget {
  final String title, location, metric, tag;
  const _StoryCard({required this.title, required this.location, required this.metric, required this.tag});
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(30), decoration: BoxDecoration(color: Colors.white.withOpacity(0.03), borderRadius: BorderRadius.circular(25), border: Border.all(color: Colors.white.withOpacity(0.05))), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(tag, style: TextStyle(color: const Color(0xFF00E5FF).withOpacity(0.5), fontWeight: FontWeight.bold, fontSize: 10)), const SizedBox(height: 8), Text(title, style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold)), const SizedBox(height: 4), Text(location, style: const TextStyle(color: Colors.white38))]), Text(metric, style: GoogleFonts.outfit(fontSize: 28, fontWeight: FontWeight.w900, color: const Color(0xFF00E5FF)))]));
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(width: 500, padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(20)), child: Row(children: [const Expanded(child: Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: TextField(decoration: InputDecoration(hintText: 'Work email', border: InputBorder.none)))), ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00E5FF), foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))), child: const Text('Subscribe'))]));
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  const _SocialIcon(this.icon);
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.symmetric(horizontal: 15), child: Icon(icon, color: Colors.white24, size: 28));
}

class LiveActivityTicker extends StatefulWidget {
  const LiveActivityTicker({super.key});
  @override
  State<LiveActivityTicker> createState() => _LiveActivityTickerState();
}

class _LiveActivityTickerState extends State<LiveActivityTicker> {
  final List<String> _activities = ["🔥 Zone A Peak", "✨ 500+ interactions", "🚀 12 checkout/sec", "📍 Beacon Active", "📊 95% Capacity"];
  int _currentIndex = 0; Timer? _timer;
  @override
  void initState() { super.initState(); _timer = Timer.periodic(const Duration(seconds: 4), (timer) { if (mounted) setState(() { _currentIndex = (_currentIndex + 1) % _activities.length; }); }); }
  @override
  void dispose() { _timer?.cancel(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Container(width: double.infinity, color: const Color(0xFF00E5FF).withOpacity(0.05), padding: const EdgeInsets.symmetric(vertical: 12), child: Center(child: Text(_activities[_currentIndex], style: const TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.bold, fontSize: 14))));
}

class InquiryDialog extends StatelessWidget {
  const InquiryDialog({super.key});
  @override
  Widget build(BuildContext context) => BackdropFilter(filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), child: Dialog(backgroundColor: const Color(0xFF151B2D), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)), child: Container(padding: const EdgeInsets.all(40), width: 500, child: Column(mainAxisSize: MainAxisSize.min, children: [Text('Contact Us', style: GoogleFonts.outfit(fontSize: 28, fontWeight: FontWeight.bold)), const SizedBox(height: 32), _buildTextField('Name'), const SizedBox(height: 16), _buildTextField('Email'), const SizedBox(height: 32), SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00E5FF), foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(vertical: 20), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text('Submit', style: TextStyle(fontWeight: FontWeight.bold))))]))));
  Widget _buildTextField(String label) => TextField(decoration: InputDecoration(labelText: label, filled: true, fillColor: Colors.white.withOpacity(0.05), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)));
}
