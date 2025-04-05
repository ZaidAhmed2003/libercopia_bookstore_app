import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelper {
  static final _supabase = Supabase.instance.client;

  static Future<String?> uploadImageToSupabase(
    String filePath,
    String folder,
  ) async {
    try {
      if (filePath.isEmpty || filePath.startsWith('http')) {
        return filePath; // Return the same URL if it's already hosted
      }

      final fileBytes = await XFile(filePath).readAsBytes();
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
      final storagePath = '$folder/$fileName';

      await _supabase.storage
          .from('images')
          .uploadBinary(storagePath, fileBytes);
      return _supabase.storage.from('images').getPublicUrl(storagePath);
    } catch (e) {
      print('Error uploading image: $e');
      return null; // Return null if upload fails
    }
  }

  static Future<bool> deleteImageFromSupabase(String imageUrl) async {
    try {
      if (imageUrl.isEmpty || !imageUrl.contains('/images/')) {
        return false; // Return false if the URL is invalid
      }

      final fileName = imageUrl.split('/images/').last;

      await _supabase.storage.from('images').remove([fileName]);
      return true; // Return true if deletion is successful
    } catch (e) {
      print('Error deleting image: $e');
      return false; // Return false if deletion fails
    }
  }
}
