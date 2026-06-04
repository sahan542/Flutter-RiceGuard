import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import '../../core/constants/app_colors.dart';
import '../../services/farmer_service.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String? selectedFarmerId;

  XFile? selectedImage;
  final picker = ImagePicker();

  Interpreter? _interpreter;
  bool _isModelLoading = true;
  bool _isPredicting = false;

  String? predictedDisease;
  double? confidence;

  final List<String> labels = const [
    'Blast',
    'Brown Spot',
    'Healthy',
    'Sheath Blight',
    'Tungro',
  ];

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset(
        'assets/models/riceguard_model.tflite',
      );

      setState(() {
        _isModelLoading = false;
      });
    } catch (e) {
      setState(() {
        _isModelLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Model load failed: $e')),
        );
      }
    }
  }

  Future<void> _pickAndPredictImage() async {
    if (_interpreter == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Model is not loaded yet')),
      );
      return;
    }

    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    setState(() {
      selectedImage = image;
      predictedDisease = null;
      confidence = null;
      _isPredicting = true;
    });

    try {
      final prediction = await _runPrediction(File(image.path));

      setState(() {
        predictedDisease = prediction['label'] as String;
        confidence = prediction['confidence'] as double;
        _isPredicting = false;
      });
    } catch (e) {
      setState(() {
        _isPredicting = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Prediction failed: $e')),
        );
      }
    }
  }

  Future<Map<String, dynamic>> _runPrediction(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final decodedImage = img.decodeImage(bytes);

    if (decodedImage == null) {
      throw Exception('Could not read image');
    }

    final resizedImage = img.copyResize(
      decodedImage,
      width: 224,
      height: 224,
    );

    final input = List.generate(
      1,
      (_) => List.generate(
        224,
        (y) => List.generate(
          224,
          (x) {
            final pixel = resizedImage.getPixel(x, y);

            return [
              pixel.r / 255.0,
              pixel.g / 255.0,
              pixel.b / 255.0,
            ];
          },
        ),
      ),
    );

    final output = List.generate(1, (_) => List.filled(5, 0.0));

    _interpreter!.run(input, output);

    final scores = output[0];

    int bestIndex = 0;
    double bestScore = scores[0];

    for (int i = 1; i < scores.length; i++) {
      if (scores[i] > bestScore) {
        bestScore = scores[i];
        bestIndex = i;
      }
    }

    return {
      'label': labels[bestIndex],
      'confidence': bestScore * 100,
    };
  }

  @override
  void dispose() {
    _interpreter?.close();
    super.dispose();
  }

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
                                  const Text('👤', style: TextStyle(fontSize: 24)),
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
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 14),

                    InkWell(
                      onTap: _isModelLoading || _isPredicting
                          ? null
                          : _pickAndPredictImage,
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
                          ),
                        ),
                        child: selectedImage == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (_isModelLoading)
                                    const CircularProgressIndicator()
                                  else ...[
                                    const Text('📷', style: TextStyle(fontSize: 48)),
                                    const SizedBox(height: 18),
                                    const Text(
                                      'Tap to upload leaf photo',
                                      style: TextStyle(
                                        color: AppColors.green,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'JPG or PNG · Close-up of rice leaf',
                                      style: TextStyle(
                                        color: AppColors.subText,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ],
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(
                                  File(selectedImage!.path),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 230,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    if (_isPredicting)
                      const Center(child: CircularProgressIndicator()),

                    if (predictedDisease != null && confidence != null)
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Prediction Result',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              predictedDisease!,
                              style: const TextStyle(
                                fontSize: 24,
                                color: AppColors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Confidence: ${confidence!.toStringAsFixed(2)}%',
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.subText,
                              ),
                            ),
                          ],
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