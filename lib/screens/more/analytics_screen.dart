import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    'Analytics',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            const Padding(
              padding: EdgeInsets.all(24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Disease distribution · Anuradhapura District · Total 4.3 ha surveyed',
                  style: TextStyle(
                    color: AppColors.subText,
                    fontSize: 15,
                  ),
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Spread Metrics by Disease',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 30),
                children: const [
                  DiseaseCard(
                    icon: '🍄',
                    disease: 'Blast',
                    severity: 'Severe',
                    dir: '33.3%',
                    dsp: '32.8%',
                    wdsi: '29.8',
                  ),

                  SizedBox(height: 16),

                  DiseaseCard(
                    icon: '🌿',
                    disease: 'Sheath Blight',
                    severity: 'Severe',
                    dir: '33.3%',
                    dsp: '46.7%',
                    wdsi: '36.4',
                  ),

                  SizedBox(height: 16),

                  DiseaseCard(
                    icon: '🟤',
                    disease: 'Brown Spot',
                    severity: 'Severe',
                    dir: '33.3%',
                    dsp: '20.6%',
                    wdsi: '17.5',
                  ),

                  SizedBox(height: 16),

                  DiseaseCard(
                    icon: '🦟',
                    disease: 'Tungro',
                    severity: 'Negligible',
                    dir: '0%',
                    dsp: '0%',
                    wdsi: '0.0',
                    green: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DiseaseCard extends StatelessWidget {
  final String icon;
  final String disease;
  final String severity;
  final String dir;
  final String dsp;
  final String wdsi;
  final bool green;

  const DiseaseCard({
    super.key,
    required this.icon,
    required this.disease,
    required this.severity,
    required this.dir,
    required this.dsp,
    required this.wdsi,
    this.green = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  disease,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: green
                      ? const Color(0xFFE7F5EB)
                      : const Color(0xFFFFEFE8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  severity,
                  style: TextStyle(
                    color: green
                        ? const Color(0xFF4FA66A)
                        : const Color(0xFFFF7A00),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(child: metric(dir, 'DIR (Eq.1)')),
              const SizedBox(width: 8),
              Expanded(child: metric(dsp, 'DSP (Eq.2)')),
              const SizedBox(width: 8),
              Expanded(child: metric(wdsi, 'WDSI (Eq.3)')),
            ],
          ),

          const SizedBox(height: 14),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: green ? 0.0 : 0.35,
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget metric(String value, String label) {
    return Container(
      height: 82,
      decoration: BoxDecoration(
        color: const Color(0xFFF1EBDD),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              color: green
                  ? const Color(0xFF4FA66A)
                  : const Color(0xFFFF7A00),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.subText,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}