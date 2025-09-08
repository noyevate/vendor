import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:vendor/common/color_extension.dart';
import 'package:vendor/firebase_options.dart';
import 'package:vendor/others/order_notification_pge.dart';
import 'package:vendor/views/onboarding/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("🔵 Background Notification Received: ${message.notification?.title}");
}


Widget defaultHome =  const SplashScreen(); 
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("✅ Firebase initialized successfully!");
  } catch (e) {
    print("❌ Firebase initialization error: $e");
  }
  checkFCMToken();
  
   await setupFirebaseNotifications();
  await GetStorage.init();
  box.erase();
  
  runApp(const MyApp());
}

// Initialize Firebase Messaging & Local Notifications
Future<void> setupFirebaseNotifications() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permission for notifications (iOS)
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('✅ Notification permission granted.');
  } else {
    print('❌ Notification permission denied.');
  }

  // Initialize Local Notifications
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings settingsInit =
      InitializationSettings(android: androidSettings);

  await flutterLocalNotificationsPlugin.initialize(
    settingsInit,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      if (response.payload != null) {
        print('🔔 Notification clicked: ${response.payload}');
        handleNotificationClick(response.payload);
      }
    },
  );

  // Handle Foreground Notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print(
        "🟢 Foreground Notification Received: ${message.notification?.title}");

    showLocalNotification(
      title: message.notification?.title ?? 'New Notification',
      body: message.notification?.body ?? 'You have a new message',
    );
  });

  // Handle Background and Clicked Notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("📩 New Notification: ${message.notification!.title}");

      // 🔥 Extract and parse the full order data
      if (message.data.containsKey("order")) {
        final String orderJson = message.data["order"];
        final Map<String, dynamic> order =
            jsonDecode(orderJson); // Convert JSON string to a Dart Map
        box.write("orderId", order["_id"]);

        print("Order ID: ${order["_id"]}");
        print("Status: ${order["orderStatus"]}");
        print("Total: ${order["grandTotal"]}");
        print("Customer: ${order["customerName"]}");
        print("order:   $message");
        print("📌 User tapped notification - Navigating to OrderNotificationPage for Order ID: ${order["_id"]}");

      // Get.to(() => OrderNotificationPage(id: order["_id"]));
        // Navigate to the order details page with the full order object
      }
    } else {
      print("message.notification = null");
    }
  });

  // Handle Terminated State Notifications
  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    if (message != null) {
      print("🔴 Notification Opened from Terminated State!");
      handleNotificationClick(message.data['orderId']);
    }
  });

  // Register Background Handler
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
}

// Function to show local notification
void showLocalNotification(
    {required String title, required String body}) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'high_importance_channel', // Channel ID
    'High Importance Notifications', // Channel Name
    importance: Importance.high,
    priority: Priority.high,
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    title,
    body,
    platformChannelSpecifics,
  );
  print("body: $body");
}

// Handle notification click and navigate
void handleNotificationClick(String? orderId) {
  if (orderId != null && orderId.isNotEmpty && orderId != "no_order_id") {
    print("📌 Navigating to Order Details Page for Order ID: $orderId");

    Get.to(() => OrderNotificationPage(id: orderId)); // ✅ GetX navigation
  } else {
    Get.to(() => OrderNotificationPage(id: box.read("orderId")));
  }
}

final box = GetStorage();

void checkFCMToken() async {
  String? fcm = await FirebaseMessaging.instance.getToken();
  print("🔑 FCM Token: $fcm");
  box.write("fcm", fcm);
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return  ScreenUtilInit(
      designSize: const Size(720, 1640),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (context , child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'vendor',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            scaffoldBackgroundColor: Tcolor.White,
            iconTheme: const IconThemeData(color: Colors.red),
            primarySwatch: Colors.blueGrey,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: defaultHome,
        );
      },
      //child: const MyHomePage(title: 'Chopnow'),
    );
  }
}


