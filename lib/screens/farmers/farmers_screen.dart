import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'add_farmer_screen.dart';

class FarmersScreen extends StatelessWidget {
  const FarmersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final farmers = [
      ['Kamal Perera', 'Anuradhapura North', 'Suwandel', '1.42 ha', 'Feb 12', 'Blast'],
      ['Nimal Silva', 'Polonnaruwa East', 'Nadu', '2.02 ha', 'Feb 15', 'Sheath Blight'],
      ['Sunil Fernando', 'Kurunegala Central', 'Rathu Heenati', '0.89 ha', 'Feb 17', 'Brown Spot'],
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
              child: Row(
                children: [
                  const Expanded(
                    child: Text('Farmers', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  ),
InkWell(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddFarmerScreen(),
      ),
    );
  },
  borderRadius: BorderRadius.circular(12),
  child: Container(
    width: 44,
    height: 44,
    decoration: BoxDecoration(
      color: AppColors.forest,
      borderRadius: BorderRadius.circular(12),
    ),
    child: const Icon(Icons.add, color: Colors.white),
  ),
)
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.border),
            Padding(
              padding: const EdgeInsets.all(24),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search farmers...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
                itemCount: farmers.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (context, i) {
                  final f = farmers[i];
                  return Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 28,
                          backgroundColor: Color(0xFFE6F4EB),
                          child: Text('👤', style: TextStyle(fontSize: 22)),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(f[0], style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                            Text('📍 ${f[1]} · ${f[2]}', style: const TextStyle(color: AppColors.subText)),
                            Text('Area: ${f[3]} · Last: ${f[4]}', style: const TextStyle(color: AppColors.subText, fontSize: 12)),
                          ]),
                        ),
                        _Tag(text: f[5]),
                        const SizedBox(width: 8),
                        const Text('›', style: TextStyle(fontSize: 24, color: AppColors.green)),
                      ],
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

class _Tag extends StatelessWidget {
  final String text;
  const _Tag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEFE8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFFFA66A)),
      ),
      child: Text(text, style: const TextStyle(color: Color(0xFFFF7A00), fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }
}