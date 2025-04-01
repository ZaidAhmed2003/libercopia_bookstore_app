import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImageUploadHelper {
  static final SupabaseClient _supabase = Supabase.instance.client;

  /// Uploads an image to Supabase and returns its public URL.
  /// If the provided imagePath is already a URL, it returns the same URL.
  static Future<String> uploadImage(String imagePath, String folder) async {
    if (imagePath.isEmpty || imagePath.startsWith('http')) return imagePath;

    try {
      final XFile pickedFile = XFile(imagePath);
      final Uint8List fileBytes = await pickedFile.readAsBytes();
      final String storagePath =
          '$folder/${DateTime.now().millisecondsSinceEpoch}.png';

      await _supabase.storage
          .from('images')
          .uploadBinary(
            storagePath,
            fileBytes,
            fileOptions: const FileOptions(upsert: false),
          );

      return _supabase.storage.from('images').getPublicUrl(storagePath);
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading image: $e');
      }
      return ''; // Return empty string if upload fails
    }
  }
}
