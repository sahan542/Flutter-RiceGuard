import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../services/auth_service.dart';
import '../auth/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          children: [
            _Header(),
            const SizedBox(height: 24),
            _QuickActionCard(),
            const SizedBox(height: 26),
            _SectionTitle(title: 'District Spread Overview'),
            const SizedBox(height: 14),
            _SpreadOverviewCard(),
            const SizedBox(height: 28),
            _SectionTitle(title: 'Recent Alerts', action: 'See all'),
            const SizedBox(height: 14),
            _AlertCard(
              title: 'Blast detected',
              subtitle: 'Kamal Perera · 2h ago',
              level: 'High',
              icon: '🍄',
              color: AppColors.danger,
            ),
            const SizedBox(height: 12),
            _AlertCard(
              title: 'Sheath Blight detected',
              subtitle: 'Nimal Silva · 1d ago',
              level: 'Medium',
              icon: '🌿',
              color: Color(0xFFE67E22),
            ),
            const SizedBox(height: 30),
            _SectionTitle(title: 'My Farmers', action: 'See all'),
            const SizedBox(height: 14),
            SizedBox(
              height: 190,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: const [
                  _FarmerCard(name: 'Kamal', variety: 'Suwandel', area: '1.42 ha', tag: 'Blast'),
                  _FarmerCard(name: 'Nimal', variety: 'Nadu', area: '2.02 ha', tag: 'Sheath Blight'),
                  _FarmerCard(name: 'Sunil', variety: 'Rathu Heenati', area: '0.89 ha', tag: 'Brown Spot'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(26, 56, 26, 34),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.forest, AppColors.green],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Good morning 👋', style: TextStyle(color: Colors.white70, fontSize: 15)),
                    SizedBox(height: 6),
                    Text('Supervisor', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('📍 Anuradhapura District', style: TextStyle(color: Colors.white70, fontSize: 13)),
                  ],
                ),
              ),
Row(
  children: [
    Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.13),
        borderRadius: BorderRadius.circular(16),
      ),
      child: IconButton(
        icon: const Icon(
          Icons.logout_rounded,
          color: Colors.white,
          size: 22,
        ),
        onPressed: () async {
          await AuthService().logout();

          if (!context.mounted) return;

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const LoginScreen(),
            ),
            (route) => false,
          );
        },
      ),
    ),

    const SizedBox(width: 10),

    Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.13),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Text(
          '🔔',
          style: TextStyle(fontSize: 23),
        ),
      ),
    ),
  ],
),
            ],
          ),
          const SizedBox(height: 28),
          Row(
            children: const [
              _StatBox(icon: '👤', value: '3', label: 'Farmers'),
              SizedBox(width: 12),
              _StatBox(icon: '🔬', value: '9', label: 'Scans'),
              SizedBox(width: 12),
              _StatBox(icon: '⚠️', value: '2', label: 'Alerts'),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String icon;
  final String value;
  final String label;

  const _StatBox({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 118,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.14),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFE8A020), Color(0xFFF5C040)]),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: const [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('QUICK ACTION', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Scan Rice Leaf', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Text('Detect disease instantly →', style: TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ),
          Text('🌿', style: TextStyle(fontSize: 52)),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String? action;

  const _SectionTitle({required this.title, this.action});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: const TextStyle(color: AppColors.text, fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          if (action != null)
            Text(action!, style: const TextStyle(color: AppColors.green, fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _SpreadOverviewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Text('Blast — Highest Risk', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(color: Color(0xFFFFEFE8), borderRadius: BorderRadius.circular(8)),
                child: const Text('Severe', style: TextStyle(color: Color(0xFFFF7A00), fontSize: 12, fontWeight: FontWeight.bold)),
              )
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: const [
              _MetricBox(value: '33.3%', title: 'DIR', sub: 'Incidence'),
              SizedBox(width: 10),
              _MetricBox(value: '32.8%', title: 'DSP', sub: 'Spread'),
              SizedBox(width: 10),
              _MetricBox(value: '29.8', title: 'WDSI', sub: 'Weighted'),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: 0.33,
              minHeight: 6,
              backgroundColor: AppColors.border,
              valueColor: AlwaysStoppedAnimation(Color(0xFFE67E22)),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricBox extends StatelessWidget {
  final String value;
  final String title;
  final String sub;

  const _MetricBox({required this.value, required this.title, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 82,
        decoration: BoxDecoration(color: AppColors.bgDeep, borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(value, style: const TextStyle(color: Color(0xFFFF7A00), fontSize: 17, fontWeight: FontWeight.bold)),
            Text(title, style: const TextStyle(color: AppColors.subText, fontSize: 12)),
            Text(sub, style: const TextStyle(color: AppColors.subText, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String level;
  final String icon;
  final Color color;

  const _AlertCard({required this.title, required this.subtitle, required this.level, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: color.withOpacity(0.12), child: Text(icon)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(subtitle, style: const TextStyle(color: AppColors.subText, fontSize: 13)),
            ]),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(8), border: Border.all(color: color.withOpacity(0.4))),
            child: Text(level, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
          )
        ],
      ),
    );
  }
}

class _FarmerCard extends StatelessWidget {
  final String name;
  final String variety;
  final String area;
  final String tag;

  const _FarmerCard({required this.name, required this.variety, required this.area, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(backgroundColor: AppColors.border, child: Text('👤')),
          const SizedBox(height: 14),
          Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(variety, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: AppColors.subText, fontSize: 12)),
          const SizedBox(height: 6),
          Text(area, style: const TextStyle(color: AppColors.subText, fontSize: 11)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(color: Color(0xFFFFEFE8), borderRadius: BorderRadius.circular(8), border: Border.all(color: Color(0xFFFFA66A))),
            child: Text(tag, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Color(0xFFFF7A00), fontSize: 12, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}