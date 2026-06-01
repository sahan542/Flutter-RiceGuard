import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../main_shell.dart';

class FarmerProfileScreen extends StatelessWidget {
  final Map<String, dynamic> farmer;

  const FarmerProfileScreen({
    super.key,
    required this.farmer,
  });

  @override
  Widget build(BuildContext context) {
    final name = farmer['name'] ?? 'Unknown';
    final phone = farmer['phone'] ?? '';
    final location = farmer['location'] ?? '';
    final district = farmer['district'] ?? '';
    final variety = farmer['variety'] ?? '';
    final areaHa = farmer['areaHa']?.toString() ?? '0';
    final disease = farmer['disease'] ?? 'None';
    final scans = farmer['scans']?.toString() ?? '0';
    final lastScan = farmer['lastScan'] ?? 'Never';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 18),
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Text(
                    'Farmer Profile',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.border),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 110),
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 36,
                              backgroundColor: Color(0x334A9E63),
                              child: Text('👤', style: TextStyle(fontSize: 32)),
                            ),
                            const SizedBox(width: 18),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '📞 $phone',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            _InfoBox(label: '📍 Location', value: location),
                            const SizedBox(width: 12),
                            _InfoBox(label: '🌾 Variety', value: variety),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _InfoBox(label: '📐 Area', value: '$areaHa ha'),
                            const SizedBox(width: 12),
                            _InfoBox(label: '🗺️ District', value: district),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      _SmallSummary(value: scans, label: 'Total Scans'),
                      const SizedBox(width: 16),
                      _SmallSummary(value: lastScan, label: 'Last Scan', orange: true),
                    ],
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'Spread Metrics for this Plot',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: const [
                      _MetricCard(
                        title: 'INCIDENCE\nRATE',
                        value: '33.3%',
                        eq: 'Eq. 1\nDIR',
                        footer: 'Affected plots / total plots',
                      ),
                      SizedBox(width: 14),
                      _MetricCard(
                        title: 'SPREAD %',
                        value: '32.8%',
                        eq: 'Eq. 2\nDSP',
                        footer: 'Affected area / total area',
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const _WideMetricCard(),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEFE8),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFFFC08A)),
                    ),
                    child: Row(
                      children: [
                        const Text('📊', style: TextStyle(fontSize: 24)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            disease == 'None'
                                ? 'No disease risk detected yet'
                                : 'Combined Risk: Severe\nApply treatment urgently. Alert district supervisors.',
                            style: const TextStyle(
                              color: Color(0xFFFF7A00),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.forest,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
onPressed: () {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => const MainShell(initialIndex: 2),
    ),
  );
},                      child: const Text(
                        '🔬  Scan Leaf Now',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final String label;
  final String value;

  const _InfoBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 88,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.white60, fontSize: 12)),
            const SizedBox(height: 8),
            Text(
              value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class _SmallSummary extends StatelessWidget {
  final String value;
  final String label;
  final bool orange;

  const _SmallSummary({
    required this.value,
    required this.label,
    this.orange = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 108,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                color: orange ? const Color(0xFFE8A020) : AppColors.green,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(label, style: const TextStyle(color: AppColors.subText)),
          ],
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String eq;
  final String footer;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.eq,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 180,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.subText,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              _EqTag(text: eq),
            ]),
            const SizedBox(height: 8),
            const Text(
              '33.3%',
              style: TextStyle(
                color: Color(0xFFFF7A00),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const _SeverityTag(),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: 0.33,
              minHeight: 7,
              backgroundColor: AppColors.bgDeep,
              valueColor: const AlwaysStoppedAnimation(Color(0xFFE67E22)),
            ),
            const SizedBox(height: 8),
            Text(footer, style: const TextStyle(color: AppColors.subText, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _WideMetricCard extends StatelessWidget {
  const _WideMetricCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Row(
            children: [
              Expanded(
                child: Text(
                  'WEIGHTED SPREAD INDEX',
                  style: TextStyle(
                    color: AppColors.subText,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              _EqTag(text: 'Eq. 3\nWDSI'),
            ],
          ),
          SizedBox(height: 6),
          Text(
            '29.8',
            style: TextStyle(
              color: Color(0xFFFF7A00),
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
          _SeverityTag(),
          SizedBox(height: 8),
          LinearProgressIndicator(
            value: 0.45,
            minHeight: 7,
            backgroundColor: AppColors.bgDeep,
            valueColor: AlwaysStoppedAnimation(Color(0xFFE67E22)),
          ),
          SizedBox(height: 8),
          Text(
            'Model confidence × plot area / total area (this scan)',
            style: TextStyle(color: AppColors.subText, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _EqTag extends StatelessWidget {
  final String text;
  const _EqTag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEFE8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color(0xFFFF7A00),
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _SeverityTag extends StatelessWidget {
  const _SeverityTag();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEFE8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'Severe',
        style: TextStyle(
          color: Color(0xFFFF7A00),
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}