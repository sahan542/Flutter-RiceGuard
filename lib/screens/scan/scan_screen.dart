import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../services/farmer_service.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {

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
StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
  stream: FarmerService().getMyFarmers(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (snapshot.hasError) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          snapshot.error.toString(),
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    final docs = snapshot.data?.docs ?? [];

    if (docs.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          'No farmers available',
          style: TextStyle(color: AppColors.subText),
        ),
      );
    }

    return Column(
      children: docs.map((doc) {
        final farmer = doc.data();

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              const Text(
                '👤',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      farmer['name'] ?? '',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      farmer['location'] ?? '',
                      style: const TextStyle(
                        color: AppColors.subText,
                      ),
                    ),
                    Text(
                      '📐 ${farmer['areaHa']} ha',
                      style: const TextStyle(
                        color: AppColors.subText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  },
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