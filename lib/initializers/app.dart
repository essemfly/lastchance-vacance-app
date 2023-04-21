import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:handover_app/repository/api_calls.dart';

final storage = new FlutterSecureStorage();

Future<void> initializeApp() async {
  timeago.setLocaleMessages('ko_KR', timeago.KoMessages());
  WidgetsFlutterBinding.ensureInitialized();

  await initFirebase();
  requestPermission();

  String firebaseDeviceToken = await getFirebaseToken();
  ApiCallResponse tokenResponse =
      await UserDeviceCall.call(deviceId: firebaseDeviceToken);
  await registerAccessToken(tokenResponse.jsonBody);
}

Future initFirebase() async {
  await Firebase.initializeApp();
}

void requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
}

Future<String> getFirebaseToken() async {
  String? firebaseToken = await FirebaseMessaging.instance.getToken();
  print("My firebaseToken is $firebaseToken");
  return firebaseToken!;
}

Future registerAccessToken(String token) async {
  await storage.write(key: 'jwt', value: token);
}

Future<String> getAccessToken() async {
  String? value = await storage.read(key: 'jwt');
  String accessToken = value!;
  return accessToken;
}
