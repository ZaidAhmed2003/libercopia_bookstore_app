import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'data/repositories/authentication/authentication_repository.dart';
import 'firebase_options.dart';

Future<void> main() async {
  /// Widgets Binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  /// InitLocal Storage
  await GetStorage.init();

  /// Await Native Splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// Initialize Supabase
  await Supabase.initialize(
    url: "https://lvkqxbvskzsmazkxilos.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx2a3F4YnZza3pzbWF6a3hpbG9zIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDI0Nzg0NjgsImV4cCI6MjA1ODA1NDQ2OH0.n2mb91TDEef6HTt2E7v-Tq5boWg3BQQ2i_4BWFjIMdY",
  );

  /// Initialize Authentication
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  runApp(const MyApp());
}
