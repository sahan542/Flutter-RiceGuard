import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../services/farmer_service.dart';

class AddFarmerScreen extends StatefulWidget {
  const AddFarmerScreen({super.key});

  @override
  State<AddFarmerScreen> createState() => _AddFarmerScreenState();
}

class _AddFarmerScreenState extends State<AddFarmerScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();
  final areaController = TextEditingController();

  final farmerService = FarmerService();

  bool isLoading = false;

  String? selectedDistrict;
  String? selectedVariety;

  final districts = [
    'Anuradhapura',
    'Polonnaruwa',
    'Kurunegala',
    'Kandy',
    'Galle',
    'Hambantota',
    'Matale',
    'Jaffna',
    'Batticaloa',
  ];

  final varieties = [
    'Suwandel',
    'Nadu',
    'Rathu Heenati',
    'Bg 300',
    'Bg 360',
    'At 307',
    'Ld 365',
    'Bg 250',
    'Pachchaperumal',
  ];

  Future<void> saveFarmer() async {
    if (nameController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        locationController.text.trim().isEmpty ||
        selectedDistrict == null ||
        areaController.text.trim().isEmpty ||
        selectedVariety == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    try {
      setState(() => isLoading = true);

      await farmerService.addFarmer(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        location: locationController.text.trim(),
        district: selectedDistrict!,
        area: areaController.text.trim(),
        variety: selectedVariety!,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Farmer saved successfully')),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    locationController.dispose();
    areaController.dispose();
    super.dispose();
  }

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
                    'Add Farmer',
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
                  _InputField(
                    label: 'Full Name',
                    hint: 'e.g. Kamal Perera',
                    icon: '✏️',
                    controller: nameController,
                  ),
                  _InputField(
                    label: 'Phone Number',
                    hint: '07X-XXXXXXX',
                    icon: '📞',
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                  _InputField(
                    label: 'Location / Village',
                    hint: 'e.g. Anuradhapura North',
                    icon: '📍',
                    controller: locationController,
                  ),
                  _DropdownField(
                    label: 'District',
                    icon: '🗺️',
                    value: selectedDistrict,
                    items: districts,
                    onChanged: (value) {
                      setState(() {
                        selectedDistrict = value;
                      });
                    },
                  ),
                  _InputField(
                    label: 'Plot Area (Acres)',
                    hint: 'e.g. 3.5',
                    icon: '📐',
                    controller: areaController,
                    keyboardType: TextInputType.number,
                  ),
                  _DropdownField(
                    label: 'Rice Variety',
                    icon: '🌾',
                    value: selectedVariety,
                    items: varieties,
                    onChanged: (value) {
                      setState(() {
                        selectedVariety = value;
                      });
                    },
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.forest,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor:
                            AppColors.forest.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: isLoading ? null : saveFarmer,
                      child: isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                          : const Text(
                              'Save Farmer',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
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

class _InputField extends StatelessWidget {
  final String label;
  final String hint;
  final String icon;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const _InputField({
    required this.label,
    required this.hint,
    required this.icon,
    required this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              color: AppColors.subText,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.bgDeep,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: Text(icon, textAlign: TextAlign.center),
                ),
                hintText: hint,
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding: const EdgeInsets.only(top: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DropdownField extends StatelessWidget {
  final String label;
  final String icon;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _DropdownField({
    required this.label,
    required this.icon,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              color: AppColors.subText,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: AppColors.bgDeep,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Text(icon, style: const TextStyle(fontSize: 18)),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: value,
                      isExpanded: true,
                      hint: const Text('Select...'),
                      dropdownColor: AppColors.bgDeep,
                      items: items
                          .map(
                            (item) => DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                      onChanged: onChanged,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}