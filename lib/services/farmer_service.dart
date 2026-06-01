import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FarmerService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> addFarmer({
    required String name,
    required String phone,
    required String location,
    required String district,
    required String area,
    required String variety,
  }) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User not logged in');
    }

    final areaAcres = double.tryParse(area) ?? 0;
    final areaHa = areaAcres * 0.405;

    await _db.collection('farmers').add({
      'supervisorId': user.uid,
      'name': name.trim(),
      'phone': phone.trim(),
      'location': location.trim(),
      'district': district,
      'areaAcres': areaAcres,
      'areaHa': double.parse(areaHa.toStringAsFixed(2)),
      'variety': variety,
      'disease': 'None',
      'scans': 0,
      'lastScan': 'Never',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMyFarmers() {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User not logged in');
    }

    return _db
        .collection('farmers')
        .where('supervisorId', isEqualTo: user.uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}