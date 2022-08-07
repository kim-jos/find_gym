import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class RegisterGymScreen extends StatefulWidget {
  const RegisterGymScreen({Key? key}) : super(key: key);

  @override
  _RegisterGymScreenState createState() => _RegisterGymScreenState();
}

class _RegisterGymScreenState extends State<RegisterGymScreen> {
  AuthService authService = AuthService();
  final gymNameController = TextEditingController();
  final gymLocationController = TextEditingController();
  final gymDescriptionController = TextEditingController();
  final gymContactsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 100.0,
              child: Image.asset('images/logo.png'),
            ),
            const SizedBox(height: 48.0),
            InputField(
              textController: gymNameController,
              hint: 'Gym name',
            ),
            const SizedBox(height: 8.0),
            InputField(
              textController: gymDescriptionController,
              hint: 'Gym description',
            ),
            const SizedBox(height: 8.0),
            InputField(
              textController: gymLocationController,
              hint: 'Gym location',
            ),
            const SizedBox(height: 8.0),
            InputField(
              textController: gymContactsController,
              hint: 'Gym contacts',
            ),
            const SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    //Implement registration functionality.
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text(
                    'Finish Registration',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  TextEditingController textController;
  String hint;
  InputField({super.key, required this.textController, required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      decoration: InputDecoration(
        hintText: "Enter $hint",
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
    );
  }
}
