import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'analytics_screen.dart';
import 'reports_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ['📊', 'Analytics', 'DIR · DSP · WDSI spread metrics'],
      ['📄', 'Reports', 'Download farmer PDF reports'],
      ['⚙️', 'Settings', 'App preferences'],
      ['❓', 'Help', 'User guide & support'],
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
                child: Text(
                  'More',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Divider(height: 1, color: AppColors.border),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (context, i) {
                  final item = items[i];

                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      if (item[1] == 'Analytics') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AnalyticsScreen(),
                          ),
                        );
                      } else if (item[1] == 'Reports') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ReportsScreen(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: const Color(0xFFE6F4EB),
                            child: Text(
                              item[0],
                              style: const TextStyle(fontSize: 24),
                            ),
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item[1],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  item[2],
                                  style: const TextStyle(
                                    color: AppColors.subText,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            '›',
                            style: TextStyle(
                              fontSize: 24,
                              color: AppColors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}