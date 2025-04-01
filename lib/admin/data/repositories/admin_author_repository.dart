import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/models/author_model.dart';

class AdminAuthorRepository extends GetxController {
  static AdminAuthorRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Fetch categories from Firestore
  Future<List<AuthorModel>> getAuthors() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('categories').get();

      return snapshot.docs.map((doc) => AuthorModel.fromSnapshot(doc)).toList();
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }
}
