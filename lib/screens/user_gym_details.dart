import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../services/repository.dart';

class UserGymDetailsScreen extends StatefulWidget {
  const UserGymDetailsScreen({Key? key}) : super(key: key);

  @override
  State<UserGymDetailsScreen> createState() => _UserGymDetailsScreenState();
}

class _UserGymDetailsScreenState extends State<UserGymDetailsScreen> {
  int gymId = Get.arguments;
  final repo = Repository();
  late Future<dynamic> classesList;

  @override
  void initState() {
    super.initState();
    classesList = repo.getClass(gymId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find Gym"),
        leading: const Icon(FontAwesomeIcons.weightScale),
        backgroundColor: Colors.blue,
        bottomOpacity: 10,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: classesList,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(snapshot.data[index]["name"]),
                            Text(snapshot.data[index]["description"]),
                            Text(snapshot.data[index]["todays_workout"]),
                            Text(snapshot.data[index]["gyms"]['name']),
                            Text(snapshot.data[index]["gyms"]['location']),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
