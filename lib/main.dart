import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:user_repository/user_repository.dart';
import 'package:khodaniya_jewellers/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen()
    ),
  );
}

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  late final TextEditingController _passwordTextController;
  late final TextEditingController _emailTextController;
  late final TextEditingController _nameTextController;

  @override
  void initState() {
    super.initState();
    _passwordTextController = TextEditingController();
    _emailTextController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordTextController.dispose();
    _emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        backgroundColor: Colors.white,
        elevation: 40, 
      ),
      body: Column(
        children: [
          TextField(
            controller: _nameTextController,
            enableSuggestions: true,
            autocorrect: true,
            decoration: const InputDecoration(hintText: "Nick name"),
          ),
          TextField(
            controller: _emailTextController,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "Email")
          ),
          TextField(
            controller: _passwordTextController,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: "Password"),
          ),
          TextButton(
            onPressed: onRegisterButtonPressed, 
            child: const Text("Register"),
          ),
          TextButton(
            onPressed: () {}, 
            child: const Text("Already registered? Login here!"),
          ),
        ],
      )
    );
  }

  void onRegisterButtonPressed() async {
    await UserRepository.instance.createUser(
      email: _emailTextController.text.trim(),
      password: _passwordTextController.text.trim(),
      name: _nameTextController.text.trim(), 
    );
  }
}


