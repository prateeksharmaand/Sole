import 'package:get/get.dart';

class NotificationController extends GetxController {
  var selectedTab = 0.obs; // 0=All, 1=Unread, 2=Read

  final tabs = ['All', 'Unread', 'Read'];

  /// Dummy data
  final notifications = List.generate(4, (index) {
    return {
      'title': 'Over Due',
      'desc': 'There are invoices overdue by more than 14 days',
      'date': '04-09-2025',
      'isRead': false,
    };
  });

  List<Map<String, dynamic>> get filteredNotifications {
    if (selectedTab.value == 1) {
      return notifications.where((e) => e['isRead'] == false).toList();
    }
    if (selectedTab.value == 2) {
      return notifications.where((e) => e['isRead'] == true).toList();
    }
    return notifications;
  }
}
