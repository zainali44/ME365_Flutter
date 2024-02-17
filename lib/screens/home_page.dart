import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testproject/screens/All_Notifications.dart';
import 'package:testproject/screens/data/dailydata.dart';
import 'package:testproject/screens/data/weeklydata.dart';

void main() => runApp(const HomePage());

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const TabBarExample(),
    );
  }
}

class TabBarExample extends StatelessWidget {
  const TabBarExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      animationDuration: const Duration(milliseconds: 1000),
      child: Scaffold(
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AllNotifications(),
                    ),
                  );
                },
                icon: Icon(Icons.short_text_rounded),
                iconSize: 30,
              ),
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1628157588553-5eeea00af15c?q=80&w=1780&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Hello, ",
                style: GoogleFonts.roboto(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              Text(
                "Moshe",
                style: GoogleFonts.roboto(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Here's your data",
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),

          const SizedBox(
            height: 10,
          ),
          //Search Bar
          TextFormField(
            decoration: const InputDecoration(
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Color.fromARGB(255, 238, 238, 238),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Column(
              children: [
                TabBar(
                  unselectedLabelColor: const Color.fromARGB(255, 0, 0, 0),
                  labelColor: Colors.white,
                  unselectedLabelStyle: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(50), // Creates a rounded corner
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  dividerColor: const Color.fromARGB(255, 255, 255, 255),
                  tabs: [
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                width: 1)),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Daily Data",
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                width: 1)),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Weekly Data",
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                width: 1)),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Monthly Data",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Expanded(
                  child: TabBarView(
                    children: [
                      Dailydata(),
                      Weeklydata(),
                      Icon(Icons.games),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
