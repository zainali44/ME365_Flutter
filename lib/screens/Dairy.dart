import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Dairy extends StatefulWidget {
  const Dairy({Key? key}) : super(key: key);

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  @override
  _DairyState createState() => _DairyState();
}

class _DairyState extends State<Dairy> {
  final CollectionReference getExerciseRef =
      FirebaseFirestore.instance.collection('diary');
  bool isLoading = true; // Set initial state to true

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  List<Event> events = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromFirebase();
  }

  void fetchDataFromFirebase() async {
    try {
      QuerySnapshot querySnapshot = await getExerciseRef.get();
      List<Event> fetchedEvents = [];

      for (var doc in querySnapshot.docs) {
        print(
            "Date: ${doc['date']}"); // This should print the date in the format "yyyy-MM-dd"

        // Assuming your date is stored as a string in the format 'yyyy-MM-dd'
        DateTime date = DateTime.parse(doc['date']);

        fetchedEvents.add(
          Event(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white30,
                border: Border.all(
                  color: const Color.fromARGB(255, 214, 214, 214),
                  width: 1,
                ),
              ),
              child: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        doc['title'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromARGB(255, 32, 32, 32),
                          fontFamily: GoogleFonts.lato().fontFamily,
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notification_add_outlined,
                            color: Colors.black,
                            size: 20,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    doc['discription'],
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 32, 32, 32),
                      fontFamily: GoogleFonts.lato().fontFamily,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )),
            ),
            dateTime: CalendarDateTime(
              year: date.year,
              month: date.month,
              day: date.day,
              calendarType: CalendarType.GREGORIAN,
            ),
          ),
        );
      }

      setState(() {
        events = fetchedEvents;
        isLoading = false; // Set loading state to false after fetching data
      });
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        isLoading = false; // Set loading state to false in case of an error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.black),
                  strokeCap: StrokeCap.round,
                  strokeWidth: 3,
                ),
              )
            : EventCalendar(
                calendarType: CalendarType.GREGORIAN,
                calendarLanguage: 'en',
                calendarOptions: CalendarOptions(
                  toggleViewType: true,
                  viewType: ViewType.DAILY,
                  headerMonthBackColor: Colors.white,
                ),
                showLoadingForEvent: true,
                dayOptions: DayOptions(
                  selectedBackgroundColor: Colors.black,
                  eventCounterColor: Colors.green,
                  weekDaySelectedColor: Colors.black,
                ),
                events: events,
              ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton(
          onPressed: () {
            _dialogBuilder(context);
          },
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
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

    bool isSaving = false; // Add a loading state for the dialog

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog.fullscreen(
          backgroundColor: Colors.white,
          insetAnimationCurve: Curves.easeInOutCubic,
          insetAnimationDuration: const Duration(milliseconds: 1000),
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Add New Diary'),
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
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 2,
                        ),
                      )
                    : Column(
                        children: [
                          TextField(
                            controller: titleController,
                            decoration: const InputDecoration(
                              labelText: 'Enter the title',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            minLines: 1,
                            maxLines: 15,
                            controller: descriptionController,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
                              labelText: 'Enter the description',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                backgroundColor: Colors.white38,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: dateController,
                            decoration: const InputDecoration(
                              labelText: 'Date',
                              labelStyle: TextStyle(
                                color: Color.fromARGB(255, 100, 100, 100),
                              ),
                            ),
                            readOnly: true,
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2500),
                              ).then((DateTime? value) {
                                if (value != null) {
                                  dateController.text =
                                      DateFormat('yyyy-MM-dd').format(value);
                                }
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isSaving =
                                    true; // Set loading state to true when starting to save data
                              });
                              if (titleController.text.isNotEmpty &&
                                  descriptionController.text.isNotEmpty &&
                                  dateController.text.isNotEmpty) {
                                print("loading state: $isSaving");
                                getExerciseRef.add({
                                  'title': titleController.text,
                                  'discription': descriptionController.text,
                                  'date': dateController.text,
                                }).then((value) {
                                  fetchDataFromFirebase();
                                  showSuccessMessage();

                                  setState(() {
                                    isSaving =
                                        false; // Set loading state to false after saving data
                                  });
                                }).catchError((error) {
                                  print("Error saving data: $error");
                                  setState(() {
                                    isSaving =
                                        false; // Set loading state to false after saving data
                                  });
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.red,
                                    closeIconColor: Colors.white,
                                    content:
                                        Text('Please fill all the fields!'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontFamily: GoogleFonts.lato().fontFamily,
                              ),
                            ),
                            child: isSaving
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  )
                                : const Text('Create Diary'),
                          ),
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
