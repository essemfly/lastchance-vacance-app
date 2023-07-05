import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:handover_app/repository/api_calls.dart';
import 'package:amplitude_flutter/amplitude.dart';
import 'package:amplitude_flutter/identify.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

const storage = FlutterSecureStorage();

Future<void> initializeApp() async {
  timeago.setLocaleMessages('ko_KR', timeago.KoMessages());
  WidgetsFlutterBinding.ensureInitialized();

  await initFirebase();
  await initAmplitude();
  requestPermission();

  String firebaseDeviceToken = await getFirebaseToken();
  ApiCallResponse tokenResponse =
      await UserDeviceCall.call(deviceId: firebaseDeviceToken);
  await registerAccessToken(tokenResponse.jsonBody);
}

Future initFirebase() async {
  await Firebase.initializeApp();
}

Future initAmplitude() async {
  final Amplitude amplitude = Amplitude.getInstance();

  await amplitude.init("7d27514165d296cec3e9ac15d149ed4d");

  final Identify identifier = Identify();
  Amplitude.getInstance().identify(identifier);
}

void requestPermission() async {
  TrackingStatus authorizationStatus =
      await AppTrackingTransparency.trackingAuthorizationStatus;
  int timeoutCount = 0;
  while (authorizationStatus == TrackingStatus.notDetermined &&
      timeoutCount < 10) {
    authorizationStatus =
        await AppTrackingTransparency.requestTrackingAuthorization();
    await Future.delayed(const Duration(milliseconds: 200));
    timeoutCount++;
  }

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
