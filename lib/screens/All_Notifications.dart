import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class AllNotifications extends StatefulWidget {
  const AllNotifications({Key? key}) : super(key: key);

  static const String routeName = '/all_notifications';

  @override
  _AllNotificationsState createState() => _AllNotificationsState();
}

class _AllNotificationsState extends State<AllNotifications> {
  List<NotificationModel> notificationsList = [];

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Allow Notifications'),
            content:
                const Text('You will be notified when you have new messages'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  AwesomeNotifications().requestPermissionToSendNotifications();
                  Navigator.pop(context);
                },
                child: const Text('Allow'),
              ),
            ],
          ),
        );
      }
    });
  }

  void loadNotifications() {
    AwesomeNotifications().listScheduledNotifications().then((notifications) {
      setState(() {
        notificationsList = notifications.cast<NotificationModel>();
        print(notifications);
      });

      if (notifications.isEmpty) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('No Notifications'),
            content: const Text('There are no notifications to display'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('All Notifications'),
        backgroundColor: const Color.fromARGB(255, 1, 192, 33),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: loadNotifications,
              child: const Text('Load Notifications'),
            ),
            if (notificationsList.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                itemCount: notificationsList.length,
                itemBuilder: (context, index) {
                  NotificationModel notification = notificationsList[index];
                  return ListTile(
                    title: Text(notification.content
                        .toString()
                        .split('title: ')[1]
                        .split(' ')[0]),
                    subtitle: Text(notification.content
                        .toString()
                        .split('body: ')[1]
                        .split(' ')[0]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        loadNotifications();
                      },
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
