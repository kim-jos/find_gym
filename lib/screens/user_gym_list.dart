import 'package:find_gym/screens/user_gym_details.dart';
import 'package:find_gym/services/repository.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class UserGymListScreen extends StatefulWidget {
  const UserGymListScreen({Key? key}) : super(key: key);

  @override
  State<UserGymListScreen> createState() => _UserGymListScreenState();
}

class _UserGymListScreenState extends State<UserGymListScreen> {
  final repo = Repository();
  late Future<dynamic> gymsList;
  @override
  void initState() {
    super.initState();
    gymsList = repo.getGymsList();
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
        child: FutureBuilder(
          future: gymsList,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              print('gymlist: ${snapshot.data}');
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    color: Colors.blue,
                    child: Row(
                      children: [
                        const Text('hello'),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [ 
                                Text(snapshot.data[index]["name"]),
                                Text(snapshot.data[index]["exercise_type"]),
                                Text(snapshot.data[index]["location"][1]),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_right),
                          onPressed: () {
                            Get.to(
                              const UserGymDetailsScreen(),
                              arguments: snapshot.data[index]['id'],
                            );
                          },
                        ),
                      ],
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
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 16.0),
        //   child: Material(
        //     color: Colors.lightBlueAccent,
        //     borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        //     elevation: 5.0,
        //     child: MaterialButton(
        //       onPressed: () async {
        //         print("list view: ${await classesList}");
        //       },
        //       minWidth: 200.0,
        //       height: 42.0,
        //       child: const Text(
        //         'Get Data',
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
