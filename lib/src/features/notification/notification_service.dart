// // notifications_service.dart
import 'dart:async';
import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final _supabase = Supabase.instance.client;
  final _notifications = FlutterLocalNotificationsPlugin();
  final List<StreamSubscription> _subscriptions = [];

  FlutterLocalNotificationsPlugin get notifications => _notifications;

  // Future<void> initialize() async {
  //   const AndroidInitializationSettings android =
  //       AndroidInitializationSettings('@mipmap/ic_launcher');
  //   const InitializationSettings settings =
  //       InitializationSettings(android: android);

  //   await _notifications.initialize(settings);

  //   // Request permissions
  //   await _notifications
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.requestNotificationsPermission();
  // }

  Future<void> initialize() async {
    const AndroidInitializationSettings android =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'channel_id', // Same as in AndroidManifest.xml
      'Important Notifications',
      importance: Importance.max,
    );

    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const InitializationSettings settings =
        InitializationSettings(android: android);

    await _notifications.initialize(settings);
  }

  void subscribeToNotifications() {
    // Message stream
    final messagesSub = _supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .order('timestamp', ascending: false)
        .listen((data) {
          if (data.isNotEmpty) {
            final newMessage = data.first;
            if (newMessage['sender_id'] != _supabase.auth.currentUser?.id) {
              _showNotification(
                'New Message',
                newMessage['message'],
                'chat',
                {
                  'chatId': newMessage['chat_id'],
                  'otherUserId': newMessage['sender_id'],
                  'currentUserName':
                      'Current User', // Replace with actual username
                },
              );
            }
          }
        });

    // Product stream
    final productsSub =
        _supabase.from('products').stream(primaryKey: ['id']).listen((data) {
      if (data.isNotEmpty) {
        final newProduct = data.last;
        _showNotification(
          'New Product',
          newProduct['title'],
          'product',
          newProduct, // Pass the entire product object
        );
      }
    });

    _subscriptions.addAll([messagesSub, productsSub]);
  }

  void dispose() {
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    _subscriptions.clear();
  }

  Future<void> _showNotification(
    String title,
    String body,
    String type,
    Map<String, dynamic> data, // Pass a map of data
  ) async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'channel_id',
      'Important Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails details = NotificationDetails(android: android);

    await _notifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      details,
      payload: '$type:${jsonEncode(data)}', // Encode data as JSON
    );
  }
}
