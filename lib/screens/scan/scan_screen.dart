import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final farmers = [
      ['Kamal Perera', 'Anuradhapura North', '1.42 ha'],
      ['Nimal Silva', 'Polonnaruwa East', '2.02 ha'],
      ['Sunil Fernando', 'Kurunegala Central', '0.89 ha'],
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
                child: Text('Scan Leaf', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              ),
            ),
            const Divider(height: 1, color: AppColors.border),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
                children: [
                  const Text(
                    'Choose a farmer then upload a rice leaf photo.',
                    style: TextStyle(color: AppColors.subText, fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  const Text('Select Farmer', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  ...farmers.map((f) => Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Row(
                          children: [
                            const Text('👤', style: TextStyle(fontSize: 24)),
                            const SizedBox(width: 18),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(f[0], style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                                Text(f[1], style: const TextStyle(color: AppColors.subText)),
                                Text('📐 ${f[2]}', style: const TextStyle(color: AppColors.subText)),
                              ],
                            )
                          ],
                        ),
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