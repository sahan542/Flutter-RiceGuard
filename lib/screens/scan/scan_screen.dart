import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../services/farmer_service.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String? selectedFarmerId;

  File? selectedImage;
  final picker = ImagePicker();

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
                child: Text(
                  'Scan Leaf',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Divider(height: 1, color: AppColors.border),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 110),
                children: [
                  const Text(
                    'Choose a farmer then upload a rice leaf photo.',
                    style: TextStyle(color: AppColors.subText, fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Select Farmer',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
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
                        return Text(
                          snapshot.error.toString(),
                          style: const TextStyle(color: Colors.red),
                        );
                      }

                      final docs = snapshot.data?.docs ?? [];

                      if (docs.isEmpty) {
                        return const Text(
                          'No farmers available',
                          style: TextStyle(color: AppColors.subText),
                        );
                      }

                      return Column(
                        children: docs.map((doc) {
                          final farmer = doc.data();
                          final isSelected = selectedFarmerId == doc.id;

                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedFarmerId = doc.id;
                              });
                            },
                            borderRadius: BorderRadius.circular(18),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFFE6F4EB)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.green
                                      : AppColors.border,
                                ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                  if (isSelected)
                                    const Icon(
                                      Icons.check,
                                      color: AppColors.green,
                                      size: 24,
                                    ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),

                  if (selectedFarmerId != null) ...[
                    const SizedBox(height: 26),
                    const Text(
                      'Upload Leaf Image',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Image upload coming next'),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(22),
                      child: Container(
                        height: 230,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE6F4EB),
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: AppColors.green,
                            width: 1.5,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('📷', style: TextStyle(fontSize: 48)),
                            SizedBox(height: 18),
                            Text(
                              'Tap to capture / upload',
                              style: TextStyle(
                                color: AppColors.green,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'JPG or PNG · Close-up of rice leaf',
                              style: TextStyle(
                                color: AppColors.subText,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}