import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class Exercise extends StatefulWidget {
  const Exercise({Key? key}) : super(key: key);

  static const routeName = '/home';

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static const String name = 'Awesome Notifications - Example App';
  static const Color mainColor = Colors.deepPurple;

  @override
  State<Exercise> createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  int selectedDayIndex = 1;
  DateTime selectedDateTime = DateTime.now();

  TextEditingController dateinput = TextEditingController();
  TextEditingController timeinput = TextEditingController();

  final Future<FirebaseApp> db = Firebase.initializeApp();

  final CollectionReference getExerciseRef =
      FirebaseFirestore.instance.collection('Dailydata');

  triggerNotification() async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 4,
        channelKey: 'scheduled',
        title: 'Just in time!',
        body: 'This is a scheduled notification',
        wakeUpScreen: true,
        category: NotificationCategory.Reminder,
        notificationLayout: NotificationLayout.BigPicture,
        bigPicture: 'asset://assets/images/delivery.jpeg',
        payload: {'uuid': 'uuid-test'},
        autoDismissible: false,
      ),
      schedule: NotificationCalendar.fromDate(
          date: DateTime.now().add(const Duration(seconds: 5))),
    );
  }

  // Array of abbreviated days of the week
  final List<String> abbreviatedDays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  List<Widget> exerciseWidgets = [];

  bool isLoading = false;

  printData() {
    setState(() {
      isLoading = true;
    });

    // Format the selected date to get the day of the week in the UTC time zone
    String dayOfWeek =
        DateFormat('EEEE', 'en_US').format(selectedDateTime.toUtc());
    print('Selected day of the week: $dayOfWeek');

    getExerciseRef.get().then((QuerySnapshot querySnapshot) {
      List<Widget> widgets = [];

      for (var doc in querySnapshot.docs) {
        // Convert Firestore 'date' string to DateTime in the UTC time zone
        DateTime docDate = DateTime.parse(doc['date'] + 'T00:00:00Z').toUtc();
        String formattedDocDay = DateFormat('EEEE', 'en_US').format(docDate);

        print(
            'Firestore date: ${doc['date']}, Formatted day: $formattedDocDay');

        // Check if the day of the week matches the selected day
        if (dayOfWeek == formattedDocDay) {
          widgets.add(
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doc['title'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Color.fromARGB(255, 59, 59, 59),
                          ),
                        ),
                        Text(
                          //Date
                          doc['date'],
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            _dialogBuilder(context);
                          },
                          icon: const Icon(
                            Icons.notification_add_outlined,
                            color: Color.fromARGB(255, 100, 100, 100),
                            size: 20,
                          ),
                        ),
                        IconButton(
                          onPressed: () => {},
                          icon: const Icon(
                            Icons.share_outlined,
                            color: Color.fromARGB(255, 100, 100, 100),
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                // Description
                Text(
                  doc['description'],
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 100, 100, 100),
                  ),
                ),
              ],
            ),
          );
        }
      }

      setState(() {
        exerciseWidgets = widgets;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise'),
        centerTitle: true,
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: db,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    height: 55,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (BuildContext context, int index) {
                        // You can customize the day representation as needed
                        return GestureDetector(
                          onTap: () {
                            // Load data for the selected day
                            // You can add your data loading logic here
                            setState(() {
                              selectedDayIndex = index + 1;
                              // Update selectedDateTime based on the selected day index
                              selectedDateTime =
                                  DateTime.now().add(Duration(days: index));
                            });
                            print('Selected day: ${abbreviatedDays[index]}');
                            printData();
                          },
                          child: Container(
                            width: 50,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: selectedDayIndex == index + 1
                                  ? Colors.black
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    abbreviatedDays[index],
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w200,
                                      color: selectedDayIndex == index + 1
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: selectedDayIndex == index + 1
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // call the printData function to print the data
                  const SizedBox(
                    height: 20,
                  ),
                  isLoading
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.black),
                          strokeCap: StrokeCap.round,
                          strokeWidth: 3,
                        )
                      : exerciseWidgets.isEmpty
                          ? const Column(
                              children: [
                                Icon(
                                  Icons.info,
                                  size: 48,
                                  color: Colors.black,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'No data found for the day.',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: exerciseWidgets.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return exerciseWidgets[index];
                                },
                              ),
                            ),
                ],
              ),
            );
          }
          if (snapshot.hasError) {
            return const Text('Error');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    DateTime NotifDateTime = DateTime.now();

    bool isSettingNotification = false;

    void showSuccessMessage() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          closeIconColor: Colors.white,
          content: Text('Notification set successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    }

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog.fullscreen(
          backgroundColor: Colors.white,
          insetAnimationCurve: Curves.easeInOutCubic,
          insetAnimationDuration: const Duration(milliseconds: 1000),
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Add Notification'),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ),
            body: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Add Notification',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Color.fromARGB(255, 59, 59, 59),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: dateinput,
                      decoration: InputDecoration(
                        labelText: 'Date',
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 100, 100, 100),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      readOnly:
                          true, //set it true, so that user will not able to edit text
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2500),
                        ).then((DateTime? value) {
                          if (value != null) {
                            setState(() {
                              selectedDateTime = value;
                              dateinput.text =
                                  DateFormat('yyyy-MM-dd').format(value);
                            });
                          }
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: timeinput,
                      decoration: InputDecoration(
                        labelText: 'Time',
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 100, 100, 100),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      readOnly:
                          true, //set it true, so that user will not able to edit text
                      onTap: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((TimeOfDay? value) {
                          if (value != null) {
                            setState(() {
                              timeinput.text = value.format(context);
                              NotifDateTime = DateTime(
                                selectedDateTime.year,
                                selectedDateTime.month,
                                selectedDateTime.day,
                                value.hour,
                                value.minute,
                              );
                            });
                          }
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        try {
                          setState(() {
                            isSettingNotification = true;
                          });
                          print('Selected date: $NotifDateTime');
                          AwesomeNotifications()
                              .createNotification(
                            content: NotificationContent(
                              id: 3,
                              channelKey: 'scheduled',
                              title: 'Scheduled Notification',
                              body:
                                  'This is a scheduled notification for ${DateFormat('yyyy-MM-dd').format(NotifDateTime)} at ${DateFormat('HH:mm').format(NotifDateTime)}',
                              wakeUpScreen: true,
                              category: NotificationCategory.Reminder,
                            ),
                            schedule: NotificationCalendar.fromDate(
                              date: NotifDateTime,
                            ),
                          )
                              .catchError((error) {
                            SnackBar(
                              content: Text('Error: $error'),
                              backgroundColor: Colors.red,
                            );
                          }).then((value) {
                            showSuccessMessage();
                          });
                        } catch (e) {
                          SnackBar(
                            content: Text('Error: $e'),
                            backgroundColor: Colors.red,
                          );
                        } finally {
                          setState(() {
                            isSettingNotification = false;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.black,
                      ),
                      child: isSettingNotification
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                                strokeWidth: 3,
                              ),
                            )
                          : const Text(
                              'Set Notification',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
