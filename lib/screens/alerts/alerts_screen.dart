import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final alerts = [
      ['High', 'Blast', 'Kamal Perera', '2h ago', '🍄', AppColors.danger],
      ['Medium', 'Sheath Blight', 'Nimal Silva', '1d ago', '🌿', Color(0xFFE67E22)],
      ['Low', 'Brown Spot', 'Sunil Fernando', '3d ago', '🟤', Color(0xFF7BC596)],
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 18, 24, 18),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Alerts', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              ),
            ),
            const Divider(height: 1, color: AppColors.border),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 100),
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEFE8),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFFFC08A)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('📢 District Broadcast Active',
                            style: TextStyle(color: Color(0xFFE67E22), fontWeight: FontWeight.bold, fontSize: 16)),
                        SizedBox(height: 8),
                        Text('Disease detections auto-notify all supervisors in Anuradhapura.',
                            style: TextStyle(color: AppColors.subText, height: 1.5)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ...alerts.map((a) => _AlertCard(
                        level: a[0] as String,
                        disease: a[1] as String,
                        farmer: a[2] as String,
                        time: a[3] as String,
                        icon: a[4] as String,
                        color: a[5] as Color,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  final String level, disease, farmer, time, icon;
  final Color color;

  const _AlertCard({
    required this.level,
    required this.disease,
    required this.farmer,
    required this.time,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _SmallTag(text: level, color: color),
              const SizedBox(width: 10),
              const CircleAvatar(radius: 5, backgroundColor: Color(0xFFE8A020)),
              const Spacer(),
              Text(time, style: const TextStyle(color: AppColors.subText)),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              CircleAvatar(radius: 26, backgroundColor: color.withOpacity(0.12), child: Text(icon)),
              const SizedBox(width: 14),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(disease, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Farmer: $farmer', style: const TextStyle(color: AppColors.subText)),
              ])
            ],
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: AppColors.bgDeep, borderRadius: BorderRadius.circular(12)),
            child: const Text('📢  All Anuradhapura supervisors notified', style: TextStyle(color: AppColors.subText)),
          )
        ],
      ),
    );
  }
}

class _SmallTag extends StatelessWidget {
  final String text;
  final Color color;
  const _SmallTag({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.35)),
      ),
      child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
    );
  }
}