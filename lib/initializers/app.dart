import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await initFirebase();
  // await registerDeivceToken();
}

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCtfLCMvQlT0s5zq307rSyF64S26R77QYo",
            authDomain: "handover-app-seokmin.firebaseapp.com",
            projectId: "handover-app-seokmin",
            storageBucket: "handover-app-seokmin.appspot.com",
            messagingSenderId: "804403366225",
            appId: "1:804403366225:web:a8cc12905074854859eb70"));
  } else {
    await Firebase.initializeApp();
  }
}

Future registerDeivceToken(String token) async {
  // Create storage
  final storage = new FlutterSecureStorage();

// Write value
  await storage.write(key: 'jwt', value: token);
}
